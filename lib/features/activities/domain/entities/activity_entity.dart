// domain/entities/activity_entity.dart
class ActivityEntity {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime startTime;
  final DateTime endTime;

  ActivityEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.startTime,
    required this.endTime,
  });
}