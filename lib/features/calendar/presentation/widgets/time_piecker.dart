import 'package:flutter/material.dart';

class TimePickerWidget extends StatelessWidget {
  final String label;
  final Function(DateTime) onPicked;
  const TimePickerWidget({super.key, required this.label, required this.onPicked});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label: '),
        TextButton(
          child: const Text('Pick Time'),
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );
            if (picked != null) onPicked(picked);
          },
        ),
      ],
    );
  }
}