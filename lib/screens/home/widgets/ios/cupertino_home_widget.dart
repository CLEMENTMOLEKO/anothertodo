import 'package:anothertodo/screens/add_task_screen/add_task_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CupertinoHomeWidget extends StatelessWidget {
  const CupertinoHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "You do not have any tasks added.",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Gap(12),
                  Center(
                    child: Text(
                      "Click on the add + icon below to add tasks",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const Gap(20),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddTaskScreen())),
                    child: DottedBorder(
                      color: Theme.of(context).colorScheme.surfaceTint,
                      borderType: BorderType.RRect,
                      dashPattern: const [12, 6],
                      radius: const Radius.circular(8),
                      strokeCap: StrokeCap.round,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 48 * 1.5),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceTint
                              .withOpacity(0.1),
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Icon(
                              CupertinoIcons.add_circled,
                              size: 48,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            const Gap(16),
                            Text(
                              "Add Your Daily Tasks",
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
