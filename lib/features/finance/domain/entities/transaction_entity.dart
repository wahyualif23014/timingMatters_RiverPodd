// domain/entities/transaction_entity.dart
class TransactionEntity {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final bool isIncome;

  TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.isIncome,
  });
}
