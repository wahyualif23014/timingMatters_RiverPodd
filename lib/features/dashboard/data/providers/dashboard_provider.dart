// data/providers/dashboard_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/dashboard_repository.dart';
import '../models/dashboard_stats.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository();
});

final dashboardStatsProvider = FutureProvider<DashboardStatsModel>((ref) async {
  final repo = ref.watch(dashboardRepositoryProvider);
  return repo.fetchDashboardStats();
});
