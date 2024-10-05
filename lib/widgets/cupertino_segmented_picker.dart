import 'package:anothertodo/common/enum_priority.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertionSegementedPicker extends StatefulWidget {
  const CupertionSegementedPicker({super.key});

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
                //widget.setPriority(value);
              });
            },
            children: const <Priority, Widget>{
              Priority.critical: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Critical'),
              ),
              Priority.high: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('High'),
              ),
              Priority.medium: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Medium'),
              ),
              Priority.low: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Low'),
              ),
            },
          ),
        ),
      ],
    );
  }
}
