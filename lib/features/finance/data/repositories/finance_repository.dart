// data/repositories/finance_repository.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:timming_matters/features/finance/data/models/budget_model.dart';
import '../models/transaction_model.dart';

class FinanceRepository {
  final _db = FirebaseDatabase.instance.ref();
  final String userId = 'user';

  Future<List<TransactionModel>> fetchTransactions() async {
    final snapshot = await _db.child('finance/$userId/transactions').get();
    if (!snapshot.exists) return [];

    final Map data = snapshot.value as Map;
    return data.entries.map((entry) {
      final txMap = Map<String, dynamic>.from(entry.value);
      return TransactionModel.fromJson(txMap);
    }).toList();
  }

  Future<void> addTransaction(TransactionModel tx) async {
    await _db.child('finance/$userId/transactions/${tx.id}').set(tx.toJson());
  }

  Future<void> deleteTransaction(String id) async {
    await _db.child('finance/$userId/transactions/$id').remove();
  }

  Future<void> updateTransaction(TransactionModel tx) async {
    await _db.child('finance/$userId/transactions/${tx.id}').update(tx.toJson());
  }

  fetchBudgets() {}

  addBudget(BudgetModel model) {}

  updateBudget(BudgetModel model) {}

  deleteBudget(String id) {}
}
