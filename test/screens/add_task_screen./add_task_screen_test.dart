import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:anothertodo/screens/add_task_screen/add_task_screen.dart';
import 'package:anothertodo/screens/add_task_screen/widgets/add_task_form.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskBloc extends MockBloc<TaskEvent, TaskState> implements TaskBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockRoute extends Fake implements Route<dynamic> {}

void main() {
  late MockTaskBloc mockTaskBloc;
  late MockNavigatorObserver navigatorObserver;

  setUp(() {
    mockTaskBloc = MockTaskBloc();
    navigatorObserver = MockNavigatorObserver();
    when(() => mockTaskBloc.state).thenReturn(const TaskState());
  });

  setUpAll(() {
    registerFallbackValue(const TaskRemoved(id: "1"));
    registerFallbackValue(MockRoute());
  });

  Future<void> pumpAddTaskScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<TaskBloc>.value(
        value: mockTaskBloc,
        child: const MaterialApp(home: AddTaskScreen()),
      ),
    );
  }

  group("CupertinoNavBar", () {
    testWidgets('Should render CupertinoNavBar with midd as Add Task',
        (tester) async {
      //Arrange
      await pumpAddTaskScreen(tester);
      //Act
      //Assert
      expect(find.text("Add Task"), findsOneWidget);
    });

    testWidgets('Should render CupertinoNavBar with trailing as CircleAvatar',
        (tester) async {
      //Arrange
      await pumpAddTaskScreen(tester);
      //Act
      //Assert
      expect(find.byType(CircleAvatar), findsOneWidget);
    });
  });

  testWidgets('Should render AddTaskForm', (tester) async {
    //Arrange
    await pumpAddTaskScreen(tester);
    //Act
    //Assert
    expect(find.byType(AddTaskForm), findsOneWidget);
  });

  group("BottomAppBar", () {
    testWidgets('Should render BottomAppBar with filled button as Save Task',
        (tester) async {
      //Arrange
      await pumpAddTaskScreen(tester);
      //Act
      //Assert
      expect(
        find.byKey(const Key("add_task_screen_bottom_app_bar_button")),
        findsOneWidget,
      );
    });

    testWidgets("Should call TaskAdded event when filled button is pressed",
        (tester) async {
      //Arrange
      await pumpAddTaskScreen(tester);
      //Act
      await tester
          .tap(find.byKey(const Key("add_task_screen_bottom_app_bar_button")));
      await tester.pumpAndSettle();
      //Assert
      verify(() => mockTaskBloc.add(any(that: isA<TaskAdded>()))).called(1);
    });

    testWidgets("Should call pop when filled button is pressed",
        (tester) async {
      //Arrange
      await tester.pumpWidget(
        BlocProvider<TaskBloc>.value(
          value: mockTaskBloc,
          child: MaterialApp(
            navigatorObservers: [navigatorObserver],
            home: const AddTaskScreen(),
          ),
        ),
      );
      //Act
      await tester
          .tap(find.byKey(const Key("add_task_screen_bottom_app_bar_button")));
      await tester.pumpAndSettle();
      //Assert
      verify(() => navigatorObserver.didPop(any(), any())).called(1);
    });
  });
}
