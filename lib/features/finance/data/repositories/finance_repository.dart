// data/repositories/finance_repository.dart
import 'package:firebase_database/firebase_database.dart';
import '../models/financial_goal_model.dart';
import '../models/budget_model.dart';
import '../models/transaction_model.dart';

class FinanceRepository {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  // === FINANCIAL GOALS ===
  DatabaseReference get _goalsRef => _db.child('financial_goals');

  Stream<List<FinancialGoalModel>> getGoalsStream() {
    return _goalsRef.onValue.map((event) {
      final List<FinancialGoalModel> goals = [];

      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final goalData = Map<String, dynamic>.from(value as Map);
          goalData['id'] = key; // Ensure ID is set
          final goal = FinancialGoalModel.fromJson(goalData);
          goals.add(goal);
        });
      }

      return goals;
    });
  }

  Future<void> addGoal(FinancialGoalModel goal) async {
    await _goalsRef.child(goal.id).set(goal.toJson());
  }

  Future<void> updateGoal(String id, Map<String, dynamic> updates) async {
    await _goalsRef.child(id).update(updates);
  }

  Future<void> deleteGoal(String id) async {
    await _goalsRef.child(id).remove();
  }

  // === BUDGETS ===
  DatabaseReference get _budgetsRef => _db.child('budgets');

  Future<List<BudgetModel>> fetchBudgets() async {
    final snapshot = await _budgetsRef.get();
    final List<BudgetModel> budgets = [];

    if (snapshot.value != null) {
      final Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        final budgetData = Map<String, dynamic>.from(value as Map);
        budgetData['id'] = key; // Ensure ID is set
        final budget = BudgetModel.fromJson(budgetData);
        budgets.add(budget);
      });
    }

    return budgets;
  }

  Future<void> addBudget(BudgetModel budget) async {
    await _budgetsRef.child(budget.id).set(budget.toJson());
  }

  Future<void> updateBudget(BudgetModel budget) async {
    await _budgetsRef.child(budget.id).update(budget.toJson());
  }

  Future<void> deleteBudget(String id) async {
    await _budgetsRef.child(id).remove();
  }

  // === TRANSACTIONS ===
  DatabaseReference get _transactionsRef => _db.child('transactions');

  /// Mengambil semua transaksi dari Firebase Realtime Database
  Future<List<TransactionModel>> fetchTransactions() async {
    try {
      final snapshot = await _transactionsRef.get();
      final List<TransactionModel> transactions = [];

      if (snapshot.value != null) {
        final Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final transactionData = Map<String, dynamic>.from(value as Map);
          transactionData['id'] = key; // Ensure ID is set
          final transaction = TransactionModel.fromJson(transactionData);
          transactions.add(transaction);
        });
      }

      // Sort transaksi berdasarkan tanggal (terbaru dulu)
      transactions.sort((a, b) => b.date.compareTo(a.date));
      return transactions;
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  /// Menambah transaksi baru ke Firebase Realtime Database
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      // Tidak menyimpan ID dalam data JSON karena akan jadi key
      final transactionData = transaction.toJson();
      transactionData.remove('id'); // Remove ID dari data
      
      await _transactionsRef.child(transaction.id).set(transactionData);
    } catch (e) {
      throw Exception('Failed to add transaction: $e');
    }
  }

  /// Mengupdate transaksi yang sudah ada
  Future<void> updateTransaction(TransactionModel transaction) async {
    try {
      // Tidak menyimpan ID dalam data JSON karena akan jadi key
      final transactionData = transaction.toJson();
      transactionData.remove('id'); // Remove ID dari data
      
      await _transactionsRef.child(transaction.id).update(transactionData);
    } catch (e) {
      throw Exception('Failed to update transaction: $e');
    }
  }

  /// Menghapus transaksi berdasarkan ID
  Future<void> deleteTransaction(String id) async {
    try {
      await _transactionsRef.child(id).remove();
    } catch (e) {
      throw Exception('Failed to delete transaction: $e');
    }
  }

  /// Mengambil transaksi berdasarkan ID
  Future<TransactionModel?> getTransactionById(String id) async {
    try {
      final snapshot = await _transactionsRef.child(id).get();
      
      if (snapshot.value != null) {
        final transactionData = Map<String, dynamic>.from(snapshot.value as Map);
        transactionData['id'] = id; // Set ID
        return TransactionModel.fromJson(transactionData);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get transaction by ID: $e');
    }
  }

  /// Mengambil transaksi berdasarkan kategori
  Future<List<TransactionModel>> getTransactionsByCategory(String category) async {
    try {
      final snapshot = await _transactionsRef
          .orderByChild('category')
          .equalTo(category)
          .get();
      
      final List<TransactionModel> transactions = [];
      
      if (snapshot.value != null) {
        final Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final transactionData = Map<String, dynamic>.from(value as Map);
          transactionData['id'] = key;
          final transaction = TransactionModel.fromJson(transactionData);
          transactions.add(transaction);
        });
      }
      
      transactions.sort((a, b) => b.date.compareTo(a.date));
      return transactions;
    } catch (e) {
      throw Exception('Failed to get transactions by category: $e');
    }
  }

  /// Mengambil transaksi berdasarkan rentang tanggal
  Future<List<TransactionModel>> getTransactionsByDateRange(
    DateTime startDate, 
    DateTime endDate
  ) async {
    try {
      final transactions = await fetchTransactions();
      
      return transactions.where((transaction) {
        return transaction.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
               transaction.date.isBefore(endDate.add(const Duration(days: 1)));
      }).toList();
    } catch (e) {
      throw Exception('Failed to get transactions by date range: $e');
    }
  }

  /// Mengambil total income
  Future<double> getTotalIncome() async {
    try {
      final transactions = await fetchTransactions();
      return transactions
          .where((t) => t.isIncome)
          .fold<double>(0.0, (double sum, t) => sum + t.amount);
    } catch (e) {
      throw Exception('Failed to get total income: $e');
    }
  }

  /// Mengambil total expense
  Future<double> getTotalExpense() async {
    try {
      final transactions = await fetchTransactions();
      return transactions
          .where((t) => !t.isIncome)
          .fold<double>(0.0, (double sum, t) => sum + t.amount);
    } catch (e) {
      throw Exception('Failed to get total expense: $e');
    }
  }

  /// Mengambil balance (income - expense)
  Future<double> getBalance() async {
    try {
      final income = await getTotalIncome();
      final expense = await getTotalExpense();
      return income - expense;
    } catch (e) {
      throw Exception('Failed to get balance: $e');
    }
  }

  /// Bulk delete transaksi
  Future<void> deleteMultipleTransactions(List<String> ids) async {
    try {
      final Map<String, Object?> updates = {};
      for (String id in ids) {
        updates[id] = null; // Set null untuk menghapus
      }
      await _transactionsRef.update(updates);
    } catch (e) {
      throw Exception('Failed to delete multiple transactions: $e');
    }
  }

  /// Clear all transactions (gunakan dengan hati-hati!)
  Future<void> clearAllTransactions() async {
    try {
      await _transactionsRef.remove();
    } catch (e) {
      throw Exception('Failed to clear all transactions: $e');
    }
  }

  /// Stream untuk realtime updates
  Stream<List<TransactionModel>> watchTransactions() {
    return _transactionsRef.onValue.map((event) {
      final List<TransactionModel> transactions = [];
      
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final transactionData = Map<String, dynamic>.from(value as Map);
          transactionData['id'] = key;
          final transaction = TransactionModel.fromJson(transactionData);
          transactions.add(transaction);
        });
      }
      
      transactions.sort((a, b) => b.date.compareTo(a.date));
      return transactions;
    });
  }

  /// Stream untuk realtime updates transaksi berdasarkan kategori
  Stream<List<TransactionModel>> watchTransactionsByCategory(String category) {
    return _transactionsRef
        .orderByChild('category')
        .equalTo(category)
        .onValue
        .map((event) {
      final List<TransactionModel> transactions = [];
      
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final transactionData = Map<String, dynamic>.from(value as Map);
          transactionData['id'] = key;
          final transaction = TransactionModel.fromJson(transactionData);
          transactions.add(transaction);
        });
      }
      
      transactions.sort((a, b) => b.date.compareTo(a.date));
      return transactions;
    });
  }

  /// Get statistics untuk dashboard
  Future<Map<String, dynamic>> getTransactionStatistics() async {
    try {
      final transactions = await fetchTransactions();
      
      final totalIncome = transactions
          .where((t) => t.isIncome)
          .fold(0.0, (sum, t) => sum + t.amount);
      
      final totalExpense = transactions
          .where((t) => !t.isIncome)
          .fold(0.0, (sum, t) => sum + t.amount);
      
      final balance = totalIncome - totalExpense;
      
      final transactionCount = transactions.length;
      final incomeCount = transactions.where((t) => t.isIncome).length;
      final expenseCount = transactions.where((t) => !t.isIncome).length;
      
      // Get categories
      final categories = <String, double>{};
      for (var transaction in transactions) {
        categories[transaction.category] = 
            (categories[transaction.category] ?? 0) + transaction.amount;
      }
      
      return {
        'totalIncome': totalIncome,
        'totalExpense': totalExpense,
        'balance': balance,
        'transactionCount': transactionCount,
        'incomeCount': incomeCount,
        'expenseCount': expenseCount,
        'categories': categories,
      };
    } catch (e) {
      throw Exception('Failed to get transaction statistics: $e');
    }
  }
}