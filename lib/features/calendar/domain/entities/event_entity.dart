// domain/entities/event_entity.dart
class EventEntity {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;

  EventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
  });
}