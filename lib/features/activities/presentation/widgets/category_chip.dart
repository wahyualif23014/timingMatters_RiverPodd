import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final Color color;

  const CategoryChip({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }
}
