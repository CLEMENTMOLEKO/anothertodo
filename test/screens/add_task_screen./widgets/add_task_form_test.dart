import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:anothertodo/screens/add_task_screen/add_task_screen.dart';
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
    when(() => mockTaskBloc.state).thenReturn(const TaskState());
  });

  Future<void> pumpAddTaskForm(WidgetTester tester) async {
    await tester.pumpWidget(BlocProvider.value(
      value: mockTaskBloc,
      child: const MaterialApp(home: AddTaskScreen()),
    ));
  }

  group("AddTaskForm", () {
    testWidgets("Should render priority picker", (tester) async {
      await pumpAddTaskForm(tester);
      expect(find.byKey(const Key("add_task_form_priority_picker")),
          findsOneWidget);
    });

    testWidgets("Should render title field", (tester) async {
      await pumpAddTaskForm(tester);
      expect(
          find.byKey(const Key("add_task_form_title_field")), findsOneWidget);
    });

    testWidgets("Should render description field", (tester) async {
      await pumpAddTaskForm(tester);
      expect(find.byKey(const Key("add_task_form_description_field")),
          findsOneWidget);
    });

    testWidgets("Should render start date field", (tester) async {
      await pumpAddTaskForm(tester);
      expect(find.byKey(const Key("add_task_form_start_date_field")),
          findsOneWidget);
    });

    testWidgets("Should render end date field", (tester) async {
      await pumpAddTaskForm(tester);
      expect(find.byKey(const Key("add_task_form_end_date_field")),
          findsOneWidget);
    });
  });
}
