import 'package:anothertodo/app_view.dart';
import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnotherTodo extends StatelessWidget {
  const AnotherTodo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (context) => TaskBloc()..add(Initial()))
    ], child: const AppView());
  }
}
