// data/repositories/habit_repository.dart
import 'package:firebase_database/firebase_database.dart';
import '../models/habit_model.dart';

class HabitRepository {
  final _db = FirebaseDatabase.instance.ref();
  final String userId = 'user';

  Future<List<HabitModel>> fetchHabits() async {
    final snapshot = await _db.child('habits/$userId').get();
    if (!snapshot.exists) return [];

    final Map data = snapshot.value as Map;
    return data.entries.map((entry) {
      final habitMap = Map<String, dynamic>.from(entry.value);
      return HabitModel.fromJson(habitMap);
    }).toList();
  }

  Future<void> addHabit(HabitModel habit) async {
    await _db.child('habits/$userId/${habit.id}').set(habit.toJson());
  }

  Future<void> deleteHabit(String id) async {
    await _db.child('habits/$userId/$id').remove();
  }

  Future<void> updateHabit(HabitModel habit) async {
    await _db.child('habits/$userId/${habit.id}').update(habit.toJson());
  }
}