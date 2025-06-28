// // data/providers/financial_goals_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/foundation.dart'; // Import for debugPrint
// import '../repositories/finance_repository.dart';
// import '../models/financial_goal_model.dart';

// // Use the same repository provider as other providers
// final financeRepositoryProvider = Provider<FinanceRepository>((ref) {
//   return FinanceRepository();
// });

// final financialGoalsProvider =
//     StateNotifierProvider<FinancialGoalsNotifier, AsyncValue<List<FinancialGoalModel>>>(
//   (ref) => FinancialGoalsNotifier(ref.read(financeRepositoryProvider)),
// );

// class FinancialGoalsNotifier extends StateNotifier<AsyncValue<List<FinancialGoalModel>>> {
//   FinancialGoalsNotifier(this._repository) : super(const AsyncValue.loading()) {
//     _init();
//   }

//   final FinanceRepository _repository;

//   void _init() {
//     state = const AsyncValue.loading();
//     _repository.getGoalsStream().listen((goals) {
//       state = AsyncValue.data(goals);
//     }, onError: (error, stackTrace) {
//       // Catch errors during stream listening (e.g., initial fetch failed, or real-time update error)
//       debugPrint('Error in FinancialGoalsNotifier stream: $error\n$stackTrace');
//       state = AsyncValue.error(error, stackTrace);
//     });
//   }

//   Future<void> addGoal(FinancialGoalModel goal) async {
//     try {
//       await _repository.addGoal(goal);
//       // State will be updated automatically through the stream
//     } catch (error, stackTrace) {
//       debugPrint('Error adding goal in Notifier: $error\n$stackTrace');
//       state = AsyncValue.error(error, stackTrace);
//     }
//   }

//   Future<void> updateGoal(String id, Map<String, dynamic> updates) async {
//     try {
//       await _repository.updateGoal(id, updates);
//       // State will be updated automatically through the stream
//     } catch (error, stackTrace) {
//       debugPrint('Error updating goal in Notifier: $error\n$stackTrace');
//       state = AsyncValue.error(error, stackTrace);
//     }
//   }

//   Future<void> deleteGoal(String id) async {
//     try {
//       await _repository.deleteGoal(id);
//       // State will be updated automatically through the stream
//     } catch (error, stackTrace) {
//       debugPrint('Error deleting goal in Notifier: $error\n$stackTrace');
//       state = AsyncValue.error(error, stackTrace);
//     }
//   }

//   Future<void> updateGoalProgress(String id, double savedAmount) async {
//     try {
//       await _repository.updateGoal(id, {'savedAmount': savedAmount});
//       // State will be updated automatically through the stream
//     } catch (error, stackTrace) {
//       debugPrint('Error updating goal progress in Notifier: $error\n$stackTrace');
//       state = AsyncValue.error(error, stackTrace);
//     }
//   }
// }
