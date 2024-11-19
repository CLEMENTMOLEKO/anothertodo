import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:anothertodo/models/task.dart';
import 'package:anothertodo/screens/add_task_screen/add_task_screen.dart';
import 'package:anothertodo/screens/add_task_screen/widgets/add_task_form.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskBloc extends MockBloc<TaskEvent, TaskState> implements TaskBloc {}

void main() {
  late MockTaskBloc mockTaskBloc;

  setUp(() {
    mockTaskBloc = MockTaskBloc();
  });

  Future<void> pumpAddTaskScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider.value(
        value: mockTaskBloc,
        child: const MaterialApp(home: AddTaskScreen()),
      ),
    );
  }

  group("CupertinoNavBar", () {
    testWidgets('Should render CupertinoNavBar with midd as Add Task',
        (tester) async {
      await pumpAddTaskScreen(tester);
      expect(find.text("Add Task"), findsOneWidget);
    });

    testWidgets('Should render CupertinoNavBar with trailing as CircleAvatar',
        (tester) async {
      await pumpAddTaskScreen(tester);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });
  });

  testWidgets('Should render AddTaskForm', (tester) async {
    await pumpAddTaskScreen(tester);
    expect(find.byType(AddTaskForm), findsOneWidget);
  });

  group("BottomAppBar", () {
    testWidgets('Should render BottomAppBar with filled button as Save Task',
        (tester) async {
      await pumpAddTaskScreen(tester);
      expect(
        find.byKey(const Key("add_task_screen_bottom_app_bar_button")),
        findsOneWidget,
      );
    });
  });
}
