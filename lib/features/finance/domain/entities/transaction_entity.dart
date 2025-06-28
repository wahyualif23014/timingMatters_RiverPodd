// domain/entities/transaction_entity.dart (Asumsi ini adalah entitas Anda)
import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String description; // <-- Pastikan ini ada di entity juga
  final double amount;
  final DateTime date;
  final String category;
  final bool isIncome;
  final String? budgetId;

  const TransactionEntity({
    required this.id,
    required this.description, // <-- Harus ada
    required this.amount,
    required this.date,
    required this.category,
    required this.isIncome,
    this.budgetId,
  });

  @override
  List<Object?> get props => [id, description, amount, date, category, isIncome, budgetId];
}