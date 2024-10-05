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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoSegmentedControl<Priority>(
            selectedColor: _selectedSegment.color,
            borderColor: _selectedSegment.color,
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
