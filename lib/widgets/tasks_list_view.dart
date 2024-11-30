import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:anothertodo/widgets/task_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/add_task_screen/add_task_screen.dart';

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
                      context.read<TaskBloc>().add(TaskCompleted(id: task.id));
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
                    key: const Key("delete-task-context-menu-button"),
                    isDestructiveAction: true,
                    onPressed: () {
                      context.read<TaskBloc>().add(TaskRemoved(id: task.id));
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
                  return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                              builder: (context) => AddTaskScreen(task: task))),
                      child: TaskWidget(task: task));
                });
          },
        );
      },
    );
  }
}
