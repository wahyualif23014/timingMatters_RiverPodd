// data/models/dashboard_stats.dart
import '../../domain/entities/dashboard_entity.dart';

class DashboardStatsModel extends DashboardStatsEntity {
  DashboardStatsModel({
    required super.totalIncome,
    required super.totalExpense,
    required super.totalActivities,
    required super.totalHabits,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalIncome: (json['totalIncome'] ?? 0).toDouble(),
      totalExpense: (json['totalExpense'] ?? 0).toDouble(),
      totalActivities: json['totalActivities'] ?? 0,
      totalHabits: json['totalHabits'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'totalIncome': totalIncome,
        'totalExpense': totalExpense,
        'totalActivities': totalActivities,
        'totalHabits': totalHabits,
      };
}