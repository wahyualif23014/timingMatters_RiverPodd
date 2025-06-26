// data/models/activity_model.dart
import '../../domain/entities/activity_entity.dart';

class ActivityModel extends ActivityEntity {
  ActivityModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.startTime,
    required super.endTime,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
      };
}