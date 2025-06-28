// lib/features/finance/data/repositories/finance_repository.dart
import 'package:firebase_database/firebase_database.dart';
import 'budget_repository.dart';
import 'transaction_repository.dart'; // This is your ExpenseRepository, handling ExpenseModel
import 'financial_goal_repository.dart'; // If you're using financial goals

class FinanceRepository {
  final FirebaseDatabase _database;
  late final BudgetRepository budgets;
  late final TransactionRepository transactions; // Renamed to transactions for consistency with providers
  late final FinancialGoalRepository goals;

  FinanceRepository(this._database) {
    budgets = BudgetRepository(_database);
    transactions = TransactionRepository(_database, budgets); // Pass budgets for spent updates
    goals = FinancialGoalRepository(_database); // Initialize if used
  }
}