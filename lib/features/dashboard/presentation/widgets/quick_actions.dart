import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildAction(Icons.add_card, "Transaction"),
        _buildAction(Icons.check_box, "Habit"),
        _buildAction(Icons.event, "Event"),
      ],
    );
  }

  Widget _buildAction(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          child: Icon(icon),
        ),
        const SizedBox(height: 6),
        Text(label),
      ],
    );
  }
}
