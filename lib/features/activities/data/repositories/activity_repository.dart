
// data/repositories/activity_repository.dart
import 'package:firebase_database/firebase_database.dart';
import '../models/activity_model.dart';

class ActivityRepository {
  final _db = FirebaseDatabase.instance.ref();
  final String userId = 'user';

  Future<List<ActivityModel>> fetchActivities() async {
    final snapshot = await _db.child('activities/$userId').get();
    if (!snapshot.exists) return [];

    final Map data = snapshot.value as Map;
    return data.entries.map((entry) {
      final activityMap = Map<String, dynamic>.from(entry.value);
      return ActivityModel.fromJson(activityMap);
    }).toList();
  }

  Future<void> addActivity(ActivityModel activity) async {
    await _db.child('activities/$userId/${activity.id}').set(activity.toJson());
  }

  Future<void> deleteActivity(String id) async {
    await _db.child('activities/$userId/$id').remove();
  }

  Future<void> updateActivity(ActivityModel activity) async {
    await _db.child('activities/$userId/${activity.id}').update(activity.toJson());
  }
}