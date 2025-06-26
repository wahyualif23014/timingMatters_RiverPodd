// data/models/transaction_model.dart
import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.id,
    required super.title,
    required super.amount,
    required super.date,
    required super.category,
    required super.isIncome,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      category: json['category'],
      isIncome: json['isIncome'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'date': date.toIso8601String(),
        'category': category,
        'isIncome': isIncome,
      };
}