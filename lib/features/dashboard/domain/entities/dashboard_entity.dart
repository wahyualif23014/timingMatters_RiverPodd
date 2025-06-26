// domain/entities/dashboard_entity.dart
class DashboardStatsEntity {
  final double totalIncome;
  final double totalExpense;
  final int totalActivities;
  final int totalHabits;

  DashboardStatsEntity({
    required this.totalIncome,
    required this.totalExpense,
    required this.totalActivities,
    required this.totalHabits,
  });
}
