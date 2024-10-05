import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../cubits/bottom_bar/bottom_bar_cubit.dart';

class BottomBarItem extends StatelessWidget {
  final String title;
  final int index;
  final IconData icon;

  const BottomBarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<BottomBarCubit>().setIndex(index),
      child: BlocBuilder<BottomBarCubit, int>(
        builder: (context, state) {
          final isActive = state == index;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
                color: isActive
                    ? Theme.of(context).colorScheme.surfaceTint.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isActive
                      ? Theme.of(context).colorScheme.surfaceTint
                      : null,
                ),
                const Gap(8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isActive
                            ? Theme.of(context).colorScheme.surfaceTint
                            : null,
                      ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
