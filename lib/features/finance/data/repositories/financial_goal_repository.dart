// data/repositories/financial_goal_repository.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/financial_goal_model.dart';

class FinancialGoalRepository {
  final DatabaseReference _goalsRef;

  FinancialGoalRepository(FirebaseDatabase database)
      : _goalsRef = database.ref().child('financial_goals');

  /// Mengambil semua tujuan keuangan secara real-time.
  Stream<List<FinancialGoalModel>> getGoalsStream() {
    return _goalsRef.onValue.map((event) {
      final List<FinancialGoalModel> goals = [];
      final dynamic data = event.snapshot.value;

      if (data != null && data is Map) {
        data.forEach((key, value) {
          try {
            final goalData = Map<String, dynamic>.from(value as Map);
            goalData['id'] = key;
            final goal = FinancialGoalModel.fromJson(goalData);
            goals.add(goal);
          } catch (e, st) {
            print('Error parsing financial goal with key $key: $e\n$st');
          }
        });
      }
      return goals;
    });
  }

  /// Menambah tujuan keuangan baru.
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

  /// Memperbarui tujuan keuangan yang sudah ada.
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

  /// Menghapus tujuan keuangan.
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
}