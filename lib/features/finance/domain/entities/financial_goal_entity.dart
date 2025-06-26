class FinancialGoalEntity {
  final String id;
  final String title;
  final double targetAmount;
  final double savedAmount;

  FinancialGoalEntity({
    required this.id,
    required this.title,
    required this.targetAmount,
    required this.savedAmount,
  });

  FinancialGoalEntity copyWith({
    String? id,
    String? title,
    double? targetAmount,
    double? savedAmount,
  }) {
    return FinancialGoalEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      targetAmount: targetAmount ?? this.targetAmount,
      savedAmount: savedAmount ?? this.savedAmount,
    );
  }
}