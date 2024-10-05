import 'dart:io';

import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:anothertodo/screens/add_task_screen.dart';
import 'package:anothertodo/widgets/cupertino_home_widget.dart';
import 'package:anothertodo/widgets/tasks_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget getBody(BuildContext context, TaskState state) {
    if (state.status == TaskStatus.initial || state.tasks.isEmpty) {
      return const CupertinoHomeWidget();
    } else if (state.status == TaskStatus.loading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    } else if (state.status == TaskStatus.success) {
      return const TasksListWidget();
    } else {
      return const Center(
        child: Text("Ohh ohh, something went wrong"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        leading: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Welcome Clement", //TODO: get this from the user once onboarding is done.
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
            )),
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.calendar),
            Gap(8),
            Icon(CupertinoIcons.bell),
          ],
        ),
        border: Border.all(color: Colors.transparent),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      "Your Tasks",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Expanded(child: getBody(context, state))
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => const AddTaskScreen())),
        shape: Platform.isAndroid ? null : const CircleBorder(),
        elevation: 4,
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
