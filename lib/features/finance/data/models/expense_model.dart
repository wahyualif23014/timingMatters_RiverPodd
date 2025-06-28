import '../../domain/entities/expense_entity.dart';

class ExpenseModel extends ExpenseEntity {
  ExpenseModel({
    required super.id,
    required super.budgetId,
    required super.description,
    required super.amount,
    required super.date,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      budgetId: json['budgetId'],
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']), // Convert string to DateTime
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'budgetId': budgetId,
        'description': description,
        'amount': amount,
        'date': date.toIso8601String(), // Convert DateTime to string for storage
      };
}