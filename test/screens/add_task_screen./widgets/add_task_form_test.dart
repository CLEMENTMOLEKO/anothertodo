import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:anothertodo/screens/add_task_screen/add_task_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/cupertino.dart';

class MockTaskBloc extends MockBloc<TaskEvent, TaskState> implements TaskBloc {}

void main() {
  late MockTaskBloc mockTaskBloc;

  setUp(() {
    mockTaskBloc = MockTaskBloc();
    when(() => mockTaskBloc.state).thenReturn(const TaskState());
  });

  setUpAll(() {
    registerFallbackValue(const TaskRemoved(id: "1"));
  });

  Future<void> pumpAddTaskForm(WidgetTester tester) async {
    await tester.pumpWidget(BlocProvider<TaskBloc>.value(
      value: mockTaskBloc,
      child: const MaterialApp(home: AddTaskScreen()),
    ));
  }

  group("AddTaskForm", () {
    testWidgets("Should render priority picker", (tester) async {
      // Arrange
      await pumpAddTaskForm(tester);
      // Act
      // Assert
      expect(
        find.byKey(const Key("add_task_form_priority_picker")),
        findsOneWidget,
      );
    });

    testWidgets("Should render title field", (tester) async {
      // Arrange
      await pumpAddTaskForm(tester);
      // Act
      // Assert
      expect(
        find.byKey(const Key("add_task_form_title_field")),
        findsOneWidget,
      );
    });

    testWidgets("Should render description field", (tester) async {
      // Arrange
      await pumpAddTaskForm(tester);
      // Act
      // Assert
      expect(
        find.byKey(const Key("add_task_form_description_field")),
        findsOneWidget,
      );
    });

    testWidgets("Should render start date field", (tester) async {
      // Arrange
      await pumpAddTaskForm(tester);
      // Act
      // Assert
      expect(
        find.byKey(const Key("add_task_form_start_date_field")),
        findsOneWidget,
      );
    });

    testWidgets("Should render end date field", (tester) async {
      // Arrange
      await pumpAddTaskForm(tester);
      // Act
      // Assert
      expect(
        find.byKey(const Key("add_task_form_end_date_field")),
        findsOneWidget,
      );
    });

    group("TaskFormDescriptionField", () {
      Future<void> pickDate(WidgetTester tester, Finder dateField) async {
        await tester.tap(dateField);
        await tester.pumpAndSettle();

        // Scroll date picker
        final datePicker = find.byKey(const Key("add_task_form_date_picker"));
        expect(datePicker, findsOneWidget);

        // Simulate scrolling the date picker
        await tester.drag(datePicker, const Offset(0, -100));
        await tester.pumpAndSettle();

        // Tap outside to close picker
        await tester.tapAt(const Offset(0, 0));
        await tester.pumpAndSettle();
      }

      testWidgets(
          "Should call add task event when description field is submitted",
          (tester) async {
        // Arrange
        await pumpAddTaskForm(tester);
        final descriptionField =
            find.byKey(const Key("add_task_form_description_field"));
        final startDateField =
            find.byKey(const Key("add_task_form_start_date_field"));
        final endDateField =
            find.byKey(const Key("add_task_form_end_date_field"));

        /// Act
        //- Handle Start Date
        await pickDate(tester, startDateField);
        // Handle End Date
        await pickDate(tester, endDateField);

        // Enter description and submit
        await tester.enterText(descriptionField, "Test Description");
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Assert
        verify(() => mockTaskBloc.add(any(that: isA<TaskAdded>()))).called(1);
      });
    });
  });
}
