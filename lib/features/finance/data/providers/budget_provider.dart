import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timming_matters/features/finance/data/providers/transaction_provider.dart';
import '../models/budget_model.dart';
import '../repositories/finance_repository.dart';

final budgetsProvider = FutureProvider<List<BudgetModel>>((ref) async {
  return ref.watch(financeRepositoryProvider).fetchBudgets();
});

final addBudgetProvider = Provider.family<Future<void>, BudgetModel>((ref, model) async {
  return ref.watch(financeRepositoryProvider).addBudget(model);
});

final updateBudgetProvider = Provider.family<Future<void>, BudgetModel>((ref, model) async {
  return ref.watch(financeRepositoryProvider).updateBudget(model);
});

final deleteBudgetProvider = Provider.family<Future<void>, String>((ref, id) async {
  return ref.watch(financeRepositoryProvider).deleteBudget(id);
});
