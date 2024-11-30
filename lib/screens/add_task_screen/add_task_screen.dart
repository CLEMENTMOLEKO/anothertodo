import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:anothertodo/common/enum_priority.dart';
import 'package:anothertodo/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'widgets/add_task_form.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;
  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  Priority taskPriority = Priority.low;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final dateTimeNowString = DateTime.now().toIso8601String();
    super.initState();
    titleController = TextEditingController(text: widget.task?.title ?? "");
    descriptionController =
        TextEditingController(text: widget.task?.description ?? "");
    startDateController = TextEditingController(
        text: widget.task?.startDate.toIso8601String() ?? dateTimeNowString);
    endDateController = TextEditingController(
        text: widget.task?.endDate.toIso8601String() ?? dateTimeNowString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          key: const Key("add_task_screen_navigation_bar"),
          trailing: const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey,
          ),
          middle: const Text(
            "Add Task",
            key: Key("add_task_screen_navigation_bar_text"),
          ),
          backgroundColor: Colors.transparent,
          border: Border.all(color: Colors.transparent),
        ),
        child: SafeArea(
          child: AddTaskForm(
            titleController: titleController,
            descriptionController: descriptionController,
            startDateController: startDateController,
            endDateController: endDateController,
            setPriority: (priority) => taskPriority = priority,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CupertinoButton.filled(
            key: const Key("add_task_screen_bottom_app_bar_button"),
            child: Text(widget.task == null ? "Add Task" : "Update Task"),
            onPressed: () {
              widget.task == null ? _addTask() : _updateTask();
              Navigator.of(context).pop();
            }),
      ),
    );
  }

  void _addTask() {
    context.read<TaskBloc>().add(
          TaskAdded(
            task: Task(
              id: const Uuid().toString(),
              title: titleController.text,
              description: descriptionController.text,
              startDate: DateTime.parse(startDateController.text.isEmpty
                  ? DateTime.now().toIso8601String()
                  : startDateController.text),
              endDate: DateTime.parse(endDateController.text.isEmpty
                  ? DateTime.now().toIso8601String()
                  : endDateController.text),
              priority: taskPriority,
            ),
          ),
        );
  }

  void _updateTask() {
    context.read<TaskBloc>().add(
          TaskUpdated(
            task: Task(
              id: widget.task!.id,
              title: titleController.text,
              description: descriptionController.text,
              startDate: DateTime.parse(startDateController.text.isEmpty
                  ? DateTime.now().toIso8601String()
                  : startDateController.text),
              endDate: DateTime.parse(
                endDateController.text.isEmpty
                    ? DateTime.now().toIso8601String()
                    : endDateController.text,
              ),
              priority: taskPriority,
            ),
          ),
        );
  }
}
