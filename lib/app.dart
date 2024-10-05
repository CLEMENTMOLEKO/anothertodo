import 'package:anothertodo/app_view.dart';
import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/bottom_bar/bottom_bar_cubit.dart';

class AnotherTodo extends StatelessWidget {
  const AnotherTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomBarCubit()),
        BlocProvider(create: (context) => TaskBloc()..add(Initial()))
      ],
      child: const AppView(),
    );
  }
}
