import 'package:flutter/material.dart';

enum Priority { low, medium, high, critical }

extension PriorityExtension on Priority {
  /// [getPriorityColor] is a private method that returns the color of the priority.
  /// This is to make sure in future when we add more colors the code doesn't break.
  /// Intellisense will help identify the switch isn't exhaustive.
  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.critical:
        return Colors.red;
      case Priority.high:
        return Colors.orange[800]!;
      case Priority.medium:
        return Colors.lime[300]!;
      case Priority.low:
        return Colors.green;
    }
  }

  /// [color] is a public method that returns the color of the priority.
  Color get color => _getPriorityColor(this);
}
