// data/repositories/calendar_repository.dart
import 'package:firebase_database/firebase_database.dart';
import '../models/event_model.dart';

class CalendarRepository {
  final _db = FirebaseDatabase.instance.ref();
  final String userId = 'user';

  Future<List<EventModel>> fetchEvents() async {
    final snapshot = await _db.child('calendar/$userId/events').get();
    if (!snapshot.exists) return [];

    final Map data = snapshot.value as Map;
    return data.entries.map((entry) {
      final map = Map<String, dynamic>.from(entry.value);
      return EventModel.fromJson(map);
    }).toList();
  }

  Future<void> addEvent(EventModel event) async {
    await _db.child('calendar/$userId/events/${event.id}').set(event.toJson());
  }

  Future<void> deleteEvent(String id) async {
    await _db.child('calendar/$userId/events/$id').remove();
  }

  Future<void> updateEvent(EventModel event) async {
    await _db.child('calendar/$userId/events/${event.id}').update(event.toJson());
  }
}
