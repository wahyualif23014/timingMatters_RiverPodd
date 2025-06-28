  import '../../domain/entities/budget_entity.dart';

  class BudgetModel extends BudgetEntity {
    BudgetModel({
      required super.id,
      required super.category,
      required super.limit,
      required super.spent,
    });

    factory BudgetModel.fromJson(Map<String, dynamic> json) {
      return BudgetModel(
        id: json['id'],
        category: json['category'],
        limit: (json['limit'] as num).toDouble(),
        spent: (json['spent'] as num).toDouble(),
      );
    }

    Map<String, dynamic> toJson() => {
          'id': id,
          'category': category,
          'limit': limit,
          'spent': spent,
        };
  }
