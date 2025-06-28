// lib/features/finance/data/repositories/transaction_repository.dart
import 'package:firebase_database/firebase_database.dart';
import '../models/expense_model.dart'; // Pastikan ini ExpenseModel
import 'budget_repository.dart'; // Diperlukan untuk memperbarui spent di budget

class TransactionRepository {
  final DatabaseReference _transactionsRef;
  final BudgetRepository _budgetRepository;

  TransactionRepository(FirebaseDatabase database, this._budgetRepository)
      : _transactionsRef = database.ref().child('transactions');

  /// Mengambil semua transaksi secara real-time dengan filter opsional.
  Stream<List<ExpenseModel>> getTransactionsStream({
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) {
    Query query = _transactionsRef;
    if (category != null && category.isNotEmpty) {
      query = query.orderByChild('category').equalTo(category);
    }
    if (startDate != null) {
      query = query.orderByChild('date').startAt(startDate.toIso8601String());
    }
    if (endDate != null) {
      // Pastikan endDate mencakup seluruh hari
      final endOfDay = endDate.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1));
      query = query.orderByChild('date').endAt(endOfDay.toIso8601String());
    }
    if (limit != null) {
      query = query.limitToFirst(limit);
    }

    return query.onValue.map((event) {
      final List<ExpenseModel> transactions = [];
      final dynamic data = event.snapshot.value;

      if (data != null && data is Map) {
        data.forEach((key, value) {
          try {
            final transactionData = Map<String, dynamic>.from(value as Map);
            transactionData['id'] = key;
            final transaction = ExpenseModel.fromJson(transactionData);
            transactions.add(transaction);
          } catch (e, st) {
            print('Error parsing transaction with key $key: $e\n$st');
          }
        });
      }
      return transactions;
    }).handleError((error, stackTrace) {
      print('Stream Error in getTransactionsStream: $error\n$stackTrace');
      return [];
    });
  }

  /// Menambah transaksi baru.
  Future<void> addTransaction(ExpenseModel transaction) async {
    try {
      final newTransactionRef = _transactionsRef.push();
      final String id = newTransactionRef.key!;
      final transactionWithId = ExpenseModel(
        id: id,
        budgetId: transaction.budgetId,
        description: transaction.description,
        amount: transaction.amount,
        date: transaction.date,
      );
      await newTransactionRef.set(transactionWithId.toJson());
      await _budgetRepository.updateBudgetSpent(
          transaction.budgetId, transaction.amount);
    } catch (e, st) {
      print('Error adding transaction: $e\n$st');
      rethrow;
    }
  }

  /// Memperbarui transaksi yang sudah ada.
  Future<void> updateTransaction(ExpenseModel oldTransaction, ExpenseModel newTransaction) async {
    try {
      await _transactionsRef.child(newTransaction.id).set(newTransaction.toJson());

      // Hitung perubahan pada 'spent'
      if (oldTransaction.budgetId != newTransaction.budgetId) {
        await _budgetRepository.updateBudgetSpent(oldTransaction.budgetId, -oldTransaction.amount);
        await _budgetRepository.updateBudgetSpent(newTransaction.budgetId, newTransaction.amount);
      } else {
        final double amountChange = newTransaction.amount - oldTransaction.amount;
        await _budgetRepository.updateBudgetSpent(newTransaction.budgetId, amountChange);
      }
    } catch (e, st) {
      print('Error updating transaction ${newTransaction.id}: $e\n$st');
      rethrow;
    }
  }

  /// Menghapus transaksi.
  Future<void> deleteTransaction(ExpenseModel transaction) async { // Menggunakan ExpenseModel
    try {
      await _transactionsRef.child(transaction.id).remove();
      await _budgetRepository.updateBudgetSpent(
          transaction.budgetId, -transaction.amount);
    } catch (e, st) {
      print('Error deleting transaction ${transaction.id}: $e\n$st');
      rethrow;
    }
  }

  /// Menghapus beberapa transaksi berdasarkan daftar ID.
  Future<void> deleteMultipleTransactions(List<String> ids) async {
    try {
      final updates = <String, dynamic>{};
      // Fetch transactions to correctly update budget spent
      // This is a simplified approach; for large lists, consider batch operations
      for (String id in ids) {
        final snapshot = await _transactionsRef.child(id).get();
        if (snapshot.exists) {
          final expense = ExpenseModel.fromJson(Map<String, dynamic>.from(snapshot.value as Map)..['id'] = id);
          updates['/${_transactionsRef.key}/$id'] = null; // Mark for deletion
          await _budgetRepository.updateBudgetSpent(expense.budgetId, -expense.amount);
        }
      }
      if (updates.isNotEmpty) {
        await FirebaseDatabase.instance.ref().update(updates); // Use root ref for multi-path update
      }
    } catch (e, st) {
      print('Error deleting multiple transactions: $e\n$st');
      rethrow;
    }
  }

  /// Menghapus semua transaksi.
  Future<void> clearAllTransactions() async {
    try {
      // Get all transactions to reverse budget spent
      final snapshot = await _transactionsRef.get();
      if (snapshot.exists && snapshot.value is Map) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        for (var entry in data.entries) {
          try {
            final expense = ExpenseModel.fromJson(Map<String, dynamic>.from(entry.value as Map)..['id'] = entry.key);
            await _budgetRepository.updateBudgetSpent(expense.budgetId, -expense.amount);
          } catch (e) {
            print('Error processing expense for clearAllTransactions: $e');
          }
        }
      }
      await _transactionsRef.remove(); // Remove all transactions from database
    } catch (e, st) {
      print('Error clearing all transactions: $e\n$st');
      rethrow;
    }
  }

  /// Mendapatkan stream statistik transaksi (perlu implementasi logikanya)
  Stream<Map<String, dynamic>> getTransactionStatisticsStream() {
    // Ini adalah contoh placeholder. Implementasi nyata akan bergantung pada bagaimana Anda menghitung statistik.
    // Anda mungkin perlu mendengarkan perubahan pada transaksi dan melakukan agregasi di sisi klien
    // atau menggunakan Cloud Functions untuk agregasi real-time.
    return _transactionsRef.onValue.map((event) {
      final dynamic data = event.snapshot.value;
      if (data == null || data is! Map) {
        return {'totalSpent': 0.0, 'transactionCount': 0};
      }

      double totalSpent = 0.0;
      int transactionCount = 0;
      data.forEach((key, value) {
        try {
          final transactionData = Map<String, dynamic>.from(value as Map);
          totalSpent += (transactionData['amount'] as num?)?.toDouble() ?? 0.0;
          transactionCount++;
        } catch (e) {
          print('Error parsing transaction for statistics: $e');
        }
      });

      return {
        'totalSpent': totalSpent,
        'transactionCount': transactionCount,
        // Tambahkan statistik lain yang Anda inginkan (misal: pengeluaran per kategori)
      };
    }).handleError((error, stackTrace) {
      print('Stream Error in getTransactionStatisticsStream: $error\n$stackTrace');
      return {'totalSpent': 0.0, 'transactionCount': 0, 'error': error.toString()};
    });
  }
}