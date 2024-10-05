import 'package:anothertodo/common/enum_priority.dart';
import 'package:anothertodo/common/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertionSegementedPicker extends StatefulWidget {
  final Function(Priority) setPriority;
  const CupertionSegementedPicker({super.key, required this.setPriority});

  @override
  State<CupertionSegementedPicker> createState() =>
      _CupertionSegementedPickerState();
}

class _CupertionSegementedPickerState extends State<CupertionSegementedPicker> {
  Priority _selectedSegment = Priority.low;

  Map<Priority, Color> priorityColors = <Priority, Color>{
    Priority.critical: Colors.red,
    Priority.high: Colors.orange[800]!,
    Priority.medium: Colors.lime[300]!,
    Priority.low: Colors.green
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoSegmentedControl<Priority>(
            selectedColor: priorityColors[_selectedSegment],
            borderColor: priorityColors[_selectedSegment],
            padding: const EdgeInsets.symmetric(horizontal: 12),
            groupValue: _selectedSegment,
            onValueChanged: (Priority value) {
              setState(() {
                _selectedSegment = value;
                widget.setPriority(value);
              });
            },
            children: {
              for (var priority in Priority.values)
                priority: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(priority.name.capitalize()),
                ),
            },
          ),
        ),
      ],
    );
  }
}
