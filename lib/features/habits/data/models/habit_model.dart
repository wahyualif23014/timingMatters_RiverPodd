// data/models/habit_model.dart
import '../../domain/entities/habit_entity.dart';

class HabitModel extends HabitEntity {
  HabitModel({
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.isCompleted,
    required super.createdAt,
  });

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category,
        'isCompleted': isCompleted,
        'createdAt': createdAt.toIso8601String(),
      };
}
