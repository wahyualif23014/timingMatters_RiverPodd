import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  return ActivityRepository();
});

final activitiesProvider = FutureProvider<List<ActivityModel>>((ref) async {
  final repo = ref.watch(activityRepositoryProvider);
  return repo.fetchActivities();
});

final addActivityProvider = Provider.family<Future<void>, ActivityModel>((ref, model) async {
  final repo = ref.watch(activityRepositoryProvider);
  await repo.addActivity(model);
});

final deleteActivityProvider = Provider.family<Future<void>, String>((ref, id) async {
  final repo = ref.watch(activityRepositoryProvider);
  await repo.deleteActivity(id);
});

final updateActivityProvider = Provider.family<Future<void>, ActivityModel>((ref, model) async {
  final repo = ref.watch(activityRepositoryProvider);
  await repo.updateActivity(model);
});
