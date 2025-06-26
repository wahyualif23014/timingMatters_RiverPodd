import 'package:firebase_database/firebase_database.dart';
import '../models/habit_model.dart';

class HabitRepository {
  final _db = FirebaseDatabase.instance.ref();

  Future<void> addHabit(HabitModel habit) async {
    await _db.child('habits').child(habit.id).set(habit.toJson());
  }

  Future<List<HabitModel>> fetchHabits() async {
    final snapshot = await _db.child('habits').get();
    if (!snapshot.exists) return [];
    return (snapshot.value as Map).entries.map((e) {
      final data = Map<String, dynamic>.from(e.value);
      return HabitModel.fromJson(data);
    }).toList();
  }

  Future<void> trackHabit(String habitId, DateTime date) async {
    final key = date.toIso8601String();
    await _db.child('habit_tracks').child(habitId).child(key).set({
      'habitId': habitId,
      'date': key,
    });
  }

  Future<List<DateTime>> fetchTrackedDates(String habitId) async {
    final snapshot = await _db.child('habit_tracks').child(habitId).get();
    if (!snapshot.exists) return [];
    return (snapshot.value as Map).entries.map((e) {
      final data = Map<String, dynamic>.from(e.value);
      return DateTime.parse(data['date']);
    }).toList();
  }
}
