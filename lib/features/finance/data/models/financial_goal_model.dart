// data/models/financial_goal_model.dart
import '../../domain/entities/financial_goal_entity.dart';

class FinancialGoalModel extends FinancialGoalEntity {
  FinancialGoalModel({
    required super.id,
    required super.title,
    required super.targetAmount,
    required super.savedAmount,
  });

  factory FinancialGoalModel.fromJson(Map<String, dynamic> json) {
    return FinancialGoalModel(
      id: json['id'], 
      title: json['title'],
      targetAmount: (json['targetAmount'] as num).toDouble(),
      savedAmount: (json['savedAmount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title, 
        'targetAmount': targetAmount,
        'savedAmount': savedAmount,
      };
}
