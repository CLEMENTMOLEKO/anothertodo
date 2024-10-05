import 'package:anothertodo/common/enum_priority.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              alignment: Alignment.topLeft,
              color: CupertinoColors.activeBlue,
              onPressed: () {
                context.read<TaskBloc>().add(CompleteTask(id: task.id));
              },
              isSelected: task.isComplete, //TODO: task.isComplete
              icon: const Icon(CupertinoIcons.circle),
              selectedIcon: const Icon(CupertinoIcons.checkmark_circle_fill),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const Gap(8),
                            Text(
                              task.description,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                      const Gap(8),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: _TaskStateWiget(taskPriority: task.priority),
                      )
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Category Long text",
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const Gap(12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 0.5,
                            ),
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          DateFormat.yMMMd().format(task.endDate),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskStateWiget extends StatelessWidget {
  final Priority taskPriority;
  const _TaskStateWiget({super.key, required this.taskPriority});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: taskPriority.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        taskPriority.name,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: taskPriority.color),
      ),
    );
  }
}
