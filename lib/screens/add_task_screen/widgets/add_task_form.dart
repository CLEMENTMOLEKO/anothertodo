import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/task_bloc/task_bloc.dart';
import '../../../common/enum_priority.dart';
import '../../../models/task.dart';
import '../../../widgets/another_text_form_field.dart';
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
  /// [onDateTimeChanged] is a callback function that is called when the user changes the date on the hosted [CupertinoDatePicker].
  void _showDatePickerDialog(Function(DateTime) onDateTimeChanged) {
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
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            use24hFormat: true,
            onDateTimeChanged: onDateTimeChanged,
          ),
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
                        key: const Key("add_task_form_priority_picker"),
                        setPriority: (priority) => _selectedSegment = priority,
                      ),
                      const Gap(16),
                      AnotherTextFormField(
                        key: const Key("add_task_form_title_field"),
                        outsideLabelText: "Title",
                        controller: widget.titleController,
                        hintText: "Add Title",
                        prefixIcon: CupertinoIcons.doc_plaintext,
                      ),
                      const Gap(16),
                      AnotherTextFormField(
                        key: const Key("add_task_form_description_field"),
                        outsideLabelText: "Description",
                        controller: widget.descriptionController,
                        hintText: "Add Description",
                        prefixIcon: CupertinoIcons.paragraph,
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
                      const Gap(16),
                      AnotherTextFormField(
                        key: const Key("add_task_form_start_date_field"),
                        outsideLabelText: "Start Date",
                        controller: widget.startDateController,
                        hintText: DateTime.now().toIso8601String(),
                        prefixIcon: Icons.calendar_month,
                        readOnly: true,
                        onTap: () => _showDatePickerDialog(
                          (DateTime newTime) {
                            widget.startDateController.text =
                                newTime.toIso8601String();
                          },
                        ),
                      ),
                      const Gap(16),
                      AnotherTextFormField(
                        key: const Key("add_task_form_end_date_field"),
                        outsideLabelText: "End Date",
                        controller: widget.endDateController,
                        hintText: DateTime.now().toIso8601String(),
                        prefixIcon: Icons.calendar_month,
                        readOnly: true,
                        onTap: () => _showDatePickerDialog(
                          (DateTime newTime) {
                            widget.endDateController.text =
                                newTime.toIso8601String();
                          },
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
