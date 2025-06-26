// data/providers/habit_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/habit_model.dart';
import '../repositories/habit_repositories.dart';
import 'package:uuid/uuid.dart';

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return HabitRepository();
});

final habitsProvider = FutureProvider<List<HabitModel>>((ref) async {
  final repo = ref.watch(habitRepositoryProvider);
  return repo.fetchHabits();
});

final addHabitProvider = Provider.family<Future<void>, HabitModel>((ref, model) async {
  final repo = ref.watch(habitRepositoryProvider);
  await repo.addHabit(model);
});

final deleteHabitProvider = Provider.family<Future<void>, String>((ref, id) async {
  final repo = ref.watch(habitRepositoryProvider);
  await repo.deleteHabit(id);
});

final updateHabitProvider = Provider.family<Future<void>, HabitModel>((ref, model) async {
  final repo = ref.watch(habitRepositoryProvider);
  await repo.updateHabit(model);
});
