// data/providers/budget_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/budget_model.dart';
import '../repositories/finance_repository.dart';

// Single repository provider
final financeRepositoryProvider = Provider<FinanceRepository>((ref) {
  return FinanceRepository();
});

// Budget providers
final budgetsProvider = FutureProvider<List<BudgetModel>>((ref) async {
  return ref.watch(financeRepositoryProvider).fetchBudgets();
});

final addBudgetProvider = FutureProvider.family<void, BudgetModel>((ref, model) async {
  await ref.read(financeRepositoryProvider).addBudget(model);
  // Refresh budgets after adding
  ref.invalidate(budgetsProvider);
});

final updateBudgetProvider = FutureProvider.family<void, BudgetModel>((ref, model) async {
  await ref.read(financeRepositoryProvider).updateBudget(model);
  // Refresh budgets after updating
  ref.invalidate(budgetsProvider);
});

final deleteBudgetProvider = FutureProvider.family<void, String>((ref, id) async {
  await ref.read(financeRepositoryProvider).deleteBudget(id);
  // Refresh budgets after deleting
  ref.invalidate(budgetsProvider);
});