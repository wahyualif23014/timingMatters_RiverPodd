// data/models/event_model.dart
import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dateTime,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'dateTime': dateTime.toIso8601String(),
      };
}
