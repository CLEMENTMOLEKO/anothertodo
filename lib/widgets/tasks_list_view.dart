import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:anothertodo/widgets/task_widget.dart';
import 'package:anothertodo/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

enum EnumTaskStatus { complete, incomplete }

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.tasks.length,
          itemBuilder: (context, index) {
            final task = state.tasks[index];
            return CupertinoContextMenu.builder(
                actions: [
                  CupertinoContextMenuAction(
                    isDefaultAction: true,
                    onPressed: () {
                      context.read<TaskBloc>().add(CompleteTask(id: task.id));
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        const Text("Complete"),
                        const Spacer(),
                        Icon(
                          task.isComplete
                              ? CupertinoIcons.checkmark_alt_circle_fill
                              : CupertinoIcons.check_mark_circled,
                          color: task.isComplete
                              ? CupertinoColors.activeBlue
                              : null,
                        )
                      ],
                    ),
                  ),
                  CupertinoContextMenuAction(
                      isDefaultAction: true,
                      onPressed: () {
                        //TODO: Archive task.
                        Navigator.of(context).pop();
                      },
                      child: const Row(
                        children: [
                          Text("Archive"),
                          Spacer(),
                          Icon(CupertinoIcons.archivebox)
                        ],
                      )),
                  CupertinoContextMenuAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      context.read<TaskBloc>().add(RemoveTask(id: task.id));
                      Navigator.of(context).pop();
                    },
                    child: const Row(
                      children: [
                        Text("Delete"),
                        Spacer(),
                        Icon(CupertinoIcons.trash_fill)
                      ],
                    ),
                  ),
                ],
                builder: (context, animation) {
                  return TaskWidget(task: task);
                });
          },
        );
      },
    );
  }
}
