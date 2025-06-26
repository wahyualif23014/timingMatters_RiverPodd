// data/providers/transaction_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction_model.dart';
import '../repositories/finance_repository.dart';

final financeRepositoryProvider = Provider<FinanceRepository>((ref) {
  return FinanceRepository();
});

final transactionsProvider = FutureProvider<List<TransactionModel>>((ref) async {
  final repo = ref.watch(financeRepositoryProvider);
  return repo.fetchTransactions();
});

final addTransactionProvider = Provider.family<Future<void>, TransactionModel>((ref, model) async {
  final repo = ref.watch(financeRepositoryProvider);
  await repo.addTransaction(model);
});

final deleteTransactionProvider = Provider.family<Future<void>, String>((ref, id) async {
  final repo = ref.watch(financeRepositoryProvider);
  await repo.deleteTransaction(id);
});

final updateTransactionProvider = Provider.family<Future<void>, TransactionModel>((ref, model) async {
  final repo = ref.watch(financeRepositoryProvider);
  await repo.updateTransaction(model);
});
