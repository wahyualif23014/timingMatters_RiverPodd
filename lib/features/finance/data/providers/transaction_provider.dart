// // data/providers/transaction_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/transaction_model.dart';
// import '../repositories/finance_repository.dart';

// // Repository provider - pastikan ini sesuai dengan repository yang sudah ada
// final financeRepositoryProvider = Provider<FinanceRepository>((ref) {
//   return FinanceRepository();
// });

// // Provider untuk mengambil semua transaksi
// final transactionsProvider = StateNotifierProvider<TransactionNotifier, AsyncValue<List<TransactionModel>>>((ref) {
//   return TransactionNotifier(ref.watch(financeRepositoryProvider));
// });

// // StateNotifier untuk mengelola state transaksi
// class TransactionNotifier extends StateNotifier<AsyncValue<List<TransactionModel>>> {
//   final FinanceRepository _repository;

//   TransactionNotifier(this._repository) : super(const AsyncValue.loading()) {
//     loadTransactions();
//   }

//   // Load semua transaksi
//   Future<void> loadTransactions() async {
//     state = const AsyncValue.loading();
//     try {
//       final transactions = await _repository.fetchTransactions();
//       state = AsyncValue.data(transactions);
//     } catch (error, stackTrace) {
//       state = AsyncValue.error(error, stackTrace);
//     }
//   }

//   // Tambah transaksi baru
//   Future<void> addTransaction(TransactionModel transaction) async {
//     try {
//       await _repository.addTransaction(transaction);
//       // Refresh data setelah menambah
//       await loadTransactions();
//     } catch (error) {
//       // Handle error jika diperlukan
//       rethrow;
//     }
//   }

//   // Update transaksi
//   Future<void> updateTransaction(TransactionModel transaction) async {
//     try {
//       await _repository.updateTransaction(transaction);
//       // Refresh data setelah update
//       await loadTransactions();
//     } catch (error) {
//       rethrow;
//     }
//   }

//   // Hapus transaksi
//   Future<void> deleteTransaction(String id) async {
//     try {
//       await _repository.deleteTransaction(id);
//       // Refresh data setelah hapus
//       await loadTransactions();
//     } catch (error) {
//       rethrow;
//     }
//   }

//   // Refresh manual
//   Future<void> refresh() async {
//     await loadTransactions();
//   }
// }

// // Provider untuk filter transaksi berdasarkan kategori
// final transactionsByCategoryProvider = Provider.family<List<TransactionModel>, String>((ref, category) {
//   final transactionsAsync = ref.watch(transactionsProvider);
  
//   return transactionsAsync.when(
//     data: (transactions) => transactions.where((t) => t.category == category).toList(),
//     loading: () => [],
//     error: (_, __) => [],
//   );
// });

// // Provider untuk mendapatkan total income
// final totalIncomeProvider = Provider<double>((ref) {
//   final transactionsAsync = ref.watch(transactionsProvider);
  
//   return transactionsAsync.when(
//     data: (transactions) => transactions
//         .where((t) => t.isIncome)
//         .fold(0.0, (sum, t) => sum + t.amount),
//     loading: () => 0.0,
//     error: (_, __) => 0.0,
//   );
// });

// // Provider untuk mendapatkan total expense
// final totalExpenseProvider = Provider<double>((ref) {
//   final transactionsAsync = ref.watch(transactionsProvider);
  
//   return transactionsAsync.when(
//     data: (transactions) => transactions
//         .where((t) => !t.isIncome)
//         .fold(0.0, (sum, t) => sum + t.amount),
//     loading: () => 0.0,
//     error: (_, __) => 0.0,
//   );
// });

// // Provider untuk mendapatkan balance (income - expense)
// final balanceProvider = Provider<double>((ref) {
//   final income = ref.watch(totalIncomeProvider);
//   final expense = ref.watch(totalExpenseProvider);
//   return income - expense;
// });

// // Provider untuk transaksi hari ini
// final todayTransactionsProvider = Provider<List<TransactionModel>>((ref) {
//   final transactionsAsync = ref.watch(transactionsProvider);
//   final today = DateTime.now();
  
//   return transactionsAsync.when(
//     data: (transactions) => transactions.where((t) {
//       return t.date.year == today.year &&
//              t.date.month == today.month &&
//              t.date.day == today.day;
//     }).toList(),
//     loading: () => [],
//     error: (_, __) => [],
//   );
// });

// // Provider untuk transaksi bulan ini
// final thisMonthTransactionsProvider = Provider<List<TransactionModel>>((ref) {
//   final transactionsAsync = ref.watch(transactionsProvider);
//   final now = DateTime.now();
  
//   return transactionsAsync.when(
//     data: (transactions) => transactions.where((t) {
//       return t.date.year == now.year && t.date.month == now.month;
//     }).toList(),
//     loading: () => [],
//     error: (_, __) => [],
//   );
// });