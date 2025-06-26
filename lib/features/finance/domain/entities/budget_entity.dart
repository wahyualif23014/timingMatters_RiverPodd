class BudgetEntity {
  final String id;
  final String category;
  final double limit;
  final double spent;

  BudgetEntity({
    required this.id,
    required this.category,
    required this.limit,
    required this.spent,
  });
}
