import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/task_bloc/task_bloc.dart';
import '../../../common/enum_priority.dart';
import '../../../models/task.dart';
import '../../../widgets/cupertino_segmented_picker.dart';

class AddTaskForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final Function(Priority) setPriority;

  const AddTaskForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.startDateController,
    required this.endDateController,
    required this.setPriority,
  });

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  Priority _selectedSegment = Priority.low;

  /// This function displays a CupertinoModalPopup using [showCupertinoModalPopup] with a reasonable fixed height
  /// which hosts [CupertinoDatePicker].
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: ListView(
          children: [
            Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(8),
                      CupertionSegementedPicker(
                        setPriority: (priority) => _selectedSegment = priority,
                      ),
                      const Gap(16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Title",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TextFormField(
                          controller: widget.titleController,
                          decoration: InputDecoration(
                            hintText: "Add Title",
                            border: InputBorder.none,
                            filled: true,
                            prefixIcon:
                                const Icon(CupertinoIcons.doc_plaintext),
                            isDense: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                      const Gap(16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Description",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TextFormField(
                          controller: widget.descriptionController,
                          maxLines: 6,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              hintText: "Add Description",
                              border: InputBorder.none,
                              filled: true,
                              prefixIcon: const Icon(CupertinoIcons.paragraph),
                              isDense: true,
                              fillColor: Colors.grey.withOpacity(0.2)),
                          onFieldSubmitted: (value) {
                            context.read<TaskBloc>().add(TaskAdded(
                                task: Task(
                                    id: const Uuid().v4().toString(),
                                    title: widget.titleController.text,
                                    description:
                                        widget.descriptionController.text,
                                    startDate: DateTime.parse(
                                        widget.startDateController.text),
                                    endDate: DateTime.parse(
                                        widget.endDateController.text),
                                    priority: _selectedSegment)));
                          },
                        ),
                      ),
                      const Gap(16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Start Date",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TextFormField(
                          controller: widget.startDateController,
                          readOnly: true,
                          onTap: () => _showDialog(
                            CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              use24hFormat: true,
                              // This is called when the user changes the time.
                              onDateTimeChanged: (DateTime newTime) {
                                widget.startDateController.text =
                                    newTime.toIso8601String();
                              },
                            ),
                          ),
                          decoration: InputDecoration(
                              hintText: DateTime.now().toIso8601String(),
                              border: InputBorder.none,
                              filled: true,
                              prefixIcon: const Icon(Icons.calendar_month),
                              isDense: true,
                              fillColor: Colors.grey.withOpacity(0.2)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "End Date",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TextFormField(
                          controller: widget.endDateController,
                          readOnly: true,
                          onTap: () => _showDialog(
                            CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              use24hFormat: true,
                              // This is called when the user changes the time.
                              onDateTimeChanged: (DateTime newTime) {
                                widget.endDateController.text =
                                    newTime.toIso8601String();
                              },
                            ),
                          ),
                          decoration: InputDecoration(
                              hintText: DateTime.now().toIso8601String(),
                              border: InputBorder.none,
                              filled: true,
                              prefixIcon: const Icon(Icons.calendar_month),
                              isDense: true,
                              fillColor: Colors.grey.withOpacity(0.2)),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
