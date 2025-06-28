// data/repositories/budget_repository.dart
import 'package:firebase_core/firebase_core.dart'; // Ini sudah benar
import 'package:firebase_database/firebase_database.dart'; // Ini yang utama dan sudah benar

import '../models/budget_model.dart';

class BudgetRepository {
  final DatabaseReference _budgetsRef;

  BudgetRepository(FirebaseDatabase database)
      : _budgetsRef = database.ref().child('budgets');

  /// Mengambil semua anggaran secara real-time.
  Stream<List<BudgetModel>> getBudgetsStream() {
    return _budgetsRef.onValue.map((event) {
      final List<BudgetModel> budgets = [];
      final dynamic data = event.snapshot.value;

      if (data != null && data is Map) {
        data.forEach((key, value) {
          try {
            final budgetData = Map<String, dynamic>.from(value as Map);
            budgetData['id'] = key;
            final budget = BudgetModel.fromJson(budgetData);
            budgets.add(budget);
          } catch (e, st) {
            print('Error parsing budget with key $key: $e\n$st');
          }
        });
      }
      return budgets;
    }).handleError((error, stackTrace) {
      print('Stream Error in getBudgetsStream: $error\n$stackTrace');
      return [];
    });
  }

  /// Menambah anggaran baru.
  Future<void> addBudget(BudgetModel budget) async {
    try {
      await _budgetsRef.child(budget.id).set(budget.toJson());
    } on FirebaseException catch (e, st) {
      print('Firebase Error adding budget: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error adding budget: $e\n$st');
      rethrow;
    }
  }

  /// Memperbarui anggaran yang sudah ada.
  Future<void> updateBudget(BudgetModel budget) async {
    try {
      await _budgetsRef.child(budget.id).update(budget.toJson());
    } on FirebaseException catch (e, st) {
      print('Firebase Error updating budget ${budget.id}: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error updating budget ${budget.id}: $e\n$st');
      rethrow;
    }
  }

  /// Menghapus anggaran.
  Future<void> deleteBudget(String id) async {
    try {
      await _budgetsRef.child(id).remove();
      // NOTE: Anda mungkin ingin menghapus transaksi terkait di sini atau di Cloud Functions
    } on FirebaseException catch (e, st) {
      print('Firebase Error deleting budget $id: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error deleting budget $id: $e\n$st');
      rethrow;
    }
  }

  /// Memperbarui jumlah 'spent' untuk anggaran tertentu secara atomik.
  /// Dipanggil dari TransactionRepository saat transaksi ditambahkan/diperbarui/dihapus.
  Future<void> updateBudgetSpent(String budgetId, double amountChange) async {
    try {
      await _budgetsRef.child(budgetId).runTransaction((currentData) {
        final data = Map<String, dynamic>.from(currentData as Map? ?? {});
        double currentSpent = (data['spent'] as num?)?.toDouble() ?? 0.0;
        data['spent'] = currentSpent + amountChange;
        return Transaction.success(data);
      });
    } on FirebaseException catch (e, st) {
      print('Firebase Error updating budget spent for $budgetId: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error updating budget spent for $budgetId: $e\n$st');
      rethrow;
    }
  }
}