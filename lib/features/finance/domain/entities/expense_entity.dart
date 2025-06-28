import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final String id;
  final String budgetId; // Link to the budget category
  final String description;
  final double amount;
  final DateTime date;

  const ExpenseEntity({
    required this.id,
    required this.budgetId,
    required this.description,
    required this.amount,
    required this.date,
  });

  @override
  List<Object?> get props => [id, budgetId, description, amount, date];
}