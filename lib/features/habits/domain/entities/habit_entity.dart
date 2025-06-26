// domain/entities/habit_entity.dart
class HabitEntity {
  final String id;
  final String name;
  final String description;
  final String category;
  final bool isCompleted;
  final DateTime createdAt;

  HabitEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.isCompleted,
    required this.createdAt,
  });
}
