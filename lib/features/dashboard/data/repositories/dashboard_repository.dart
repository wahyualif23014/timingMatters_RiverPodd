// data/repositories/dashboard_repository.dart
import 'package:firebase_database/firebase_database.dart';
import '../models/dashboard_stats.dart';

class DashboardRepository {
  final _db = FirebaseDatabase.instance.ref();
  final String userId = 'user';

  Future<DashboardStatsModel> fetchDashboardStats() async {
    final snapshot = await _db.child('dashboard/$userId/stats').get();
    if (!snapshot.exists) {
      return DashboardStatsModel(
        totalIncome: 0,
        totalExpense: 0,
        totalActivities: 0,
        totalHabits: 0,
      );
    }

    final json = Map<String, dynamic>.from(snapshot.value as Map);
    return DashboardStatsModel.fromJson(json);
  }
}