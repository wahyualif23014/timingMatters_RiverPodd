// data/repositories/finance_repository.dart
import 'package:firebase_core/firebase_core.dart'; // Import for FirebaseException
import 'package:firebase_database/firebase_database.dart';
import '../models/financial_goal_model.dart';
import '../models/budget_model.dart'; // Pastikan BudgetModel diimpor
import '../models/transaction_model.dart'; // Pastikan TransactionModel diimpor

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
          try {
            final goalData = Map<String, dynamic>.from(value as Map);
            goalData['id'] = key; // Ensure ID is set
            final goal = FinancialGoalModel.fromJson(goalData);
            goals.add(goal);
          } catch (e, st) {
            // Log parsing errors for individual goals but allow others to load
            print('Error parsing financial goal with key $key: $e\n$st');
          }
        });
      }
      return goals;
    });
  }

  Future<void> addGoal(FinancialGoalModel goal) async {
    try {
      await _goalsRef.child(goal.id).set(goal.toJson());
    } on FirebaseException catch (e, st) {
      print('Firebase Error adding goal: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error adding goal: $e\n$st');
      rethrow;
    }
  }

  Future<void> updateGoal(String id, Map<String, dynamic> updates) async {
    try {
      await _goalsRef.child(id).update(updates);
    } on FirebaseException catch (e, st) {
      print('Firebase Error updating goal $id: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error updating goal $id: $e\n$st');
      rethrow;
    }
  }

  Future<void> deleteGoal(String id) async {
    try {
      await _goalsRef.child(id).remove();
    } on FirebaseException catch (e, st) {
      print('Firebase Error deleting goal $id: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error deleting goal $id: $e\n$st');
      rethrow;
    }
  }

  // === BUDGETS ===
  DatabaseReference get _budgetsRef => _db.child('budgets');

  Future<List<BudgetModel>> fetchBudgets() async {
    try {
      final snapshot = await _budgetsRef.get();
      final List<BudgetModel> budgets = [];

      if (snapshot.value != null) {
        final Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          try {
            final budgetData = Map<String, dynamic>.from(value as Map);
            budgetData['id'] = key; // Ensure ID is set
            final budget = BudgetModel.fromJson(budgetData);
            budgets.add(budget);
          } catch (e, st) {
            print('Error parsing budget with key $key: $e\n$st');
          }
        });
      }
      return budgets;
    } on FirebaseException catch (e, st) {
      print('Firebase Error fetching budgets: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error fetching budgets: $e\n$st');
      rethrow;
    }
  }

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

  Future<void> deleteBudget(String id) async {
    try {
      await _budgetsRef.child(id).remove();
    } on FirebaseException catch (e, st) {
      print('Firebase Error deleting budget $id: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error deleting budget $id: $e\n$st');
      rethrow;
    }
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
          try {
            final transactionData = Map<String, dynamic>.from(value as Map);
            transactionData['id'] = key; // Ensure ID is set
            final transaction = TransactionModel.fromJson(transactionData);
            transactions.add(transaction);
          } catch (e, st) {
            print('Error parsing transaction with key $key: $e\n$st');
          }
        });
      }
      transactions.sort((a, b) => b.date.compareTo(a.date));
      return transactions;
    } on FirebaseException catch (e, st) {
      print('Firebase Error fetching transactions: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error fetching transactions: $e\n$st');
      rethrow;
    }
  }

  /// Menambah transaksi baru ke Firebase Realtime Database
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      final transactionData = transaction.toJson();
      transactionData.remove('id'); // Remove ID from data as it will be the key

      await _transactionsRef.child(transaction.id).set(transactionData);
    } on FirebaseException catch (e, st) {
      print('Firebase Error adding transaction: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error adding transaction: $e\n$st');
      rethrow;
    }
  }

  /// Mengupdate transaksi yang sudah ada
  Future<void> updateTransaction(TransactionModel transaction) async {
    try {
      final transactionData = transaction.toJson();
      transactionData.remove('id'); // Remove ID from data as it will be the key

      await _transactionsRef.child(transaction.id).update(transactionData);
    } on FirebaseException catch (e, st) {
      print('Firebase Error updating transaction ${transaction.id}: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error updating transaction ${transaction.id}: $e\n$st');
      rethrow;
    }
  }

  /// Menghapus transaksi berdasarkan ID
  Future<void> deleteTransaction(String id) async {
    try {
      await _transactionsRef.child(id).remove();
    } on FirebaseException catch (e, st) {
      print('Firebase Error deleting transaction $id: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error deleting transaction $id: $e\n$st');
      rethrow;
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
    } on FirebaseException catch (e, st) {
      print('Firebase Error getting transaction by ID $id: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error getting transaction by ID $id: $e\n$st');
      rethrow;
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
          try {
            final transactionData = Map<String, dynamic>.from(value as Map);
            transactionData['id'] = key;
            final transaction = TransactionModel.fromJson(transactionData);
            transactions.add(transaction);
          } catch (e, st) {
            print('Error parsing transaction with key $key (category $category): $e\n$st');
          }
        });
      }
      transactions.sort((a, b) => b.date.compareTo(a.date));
      return transactions;
    } on FirebaseException catch (e, st) {
      print('Firebase Error getting transactions by category $category: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error getting transactions by category $category: $e\n$st');
      rethrow;
    }
  }

  /// Mengambil transaksi berdasarkan rentang tanggal
  Future<List<TransactionModel>> getTransactionsByDateRange(DateTime startDate, DateTime endDate) async {
    try {
      final transactions = await fetchTransactions();

      return transactions.where((transaction) {
        return transaction.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
            transaction.date.isBefore(endDate.add(const Duration(days: 1)));
      }).toList();
    } on FirebaseException catch (e, st) {
      print('Firebase Error getting transactions by date range: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error getting transactions by date range: $e\n$st');
      rethrow;
    }
  }

  /// Mengambil total income
  Future<double> getTotalIncome() async {
    try {
      final transactions = await fetchTransactions();
      return transactions
          .where((t) => t.isIncome)
          .fold<double>(0.0, (double sum, t) => sum + t.amount);
    } on FirebaseException catch (e, st) {
      print('Firebase Error getting total income: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error getting total income: $e\n$st');
      rethrow;
    }
  }

  /// Mengambil total expense
  Future<double> getTotalExpense() async {
    try {
      final transactions = await fetchTransactions();
      return transactions
          .where((t) => !t.isIncome)
          .fold<double>(0.0, (double sum, t) => sum + t.amount);
    } on FirebaseException catch (e, st) {
      print('Firebase Error getting total expense: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error getting total expense: $e\n$st');
      rethrow;
    }
  }

  /// Mengambil balance (income - expense)
  Future<double> getBalance() async {
    try {
      final income = await getTotalIncome();
      final expense = await getTotalExpense();
      return income - expense;
    } on FirebaseException catch (e, st) {
      print('Firebase Error getting balance: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error getting balance: $e\n$st');
      rethrow;
    }
  }

  /// Bulk delete transaksi
  Future<void> deleteMultipleTransactions(List<String> ids) async {
    try {
      final Map<String, Object?> updates = {};
      for (String id in ids) {
        updates[id] = null; // Set null to delete
      }
      await _transactionsRef.update(updates);
    } on FirebaseException catch (e, st) {
      print('Firebase Error deleting multiple transactions: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error deleting multiple transactions: $e\n$st');
      rethrow;
    }
  }

  /// Clear all transactions (use with caution!)
  Future<void> clearAllTransactions() async {
    try {
      await _transactionsRef.remove();
    } on FirebaseException catch (e, st) {
      print('Firebase Error clearing all transactions: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error clearing all transactions: $e\n$st');
      rethrow;
    }
  }

  /// Stream untuk realtime updates
  Stream<List<TransactionModel>> watchTransactions() {
    return _transactionsRef.onValue.map((event) {
      final List<TransactionModel> transactions = [];

      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          try {
            final transactionData = Map<String, dynamic>.from(value as Map);
            transactionData['id'] = key;
            final transaction = TransactionModel.fromJson(transactionData);
            transactions.add(transaction);
          } catch (e, st) {
            print('Error parsing transaction with key $key (watchTransactions): $e\n$st');
          }
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
              try {
                final transactionData = Map<String, dynamic>.from(value as Map);
                transactionData['id'] = key;
                final transaction = TransactionModel.fromJson(transactionData);
                transactions.add(transaction);
              } catch (e, st) {
                print('Error parsing transaction with key $key (watchTransactionsByCategory $category): $e\n$st');
              }
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
    } on FirebaseException catch (e, st) {
      print('Firebase Error getting transaction statistics: ${e.message} (${e.code})\n$st');
      rethrow;
    } catch (e, st) {
      print('Unexpected Error getting transaction statistics: $e\n$st');
      rethrow;
    }
  }
}
