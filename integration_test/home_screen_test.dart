import 'package:anothertodo/app.dart';
import 'package:anothertodo/screens/add_task_screen/add_task_screen.dart';
import 'package:anothertodo/screens/home/home_screen.dart';
import 'package:anothertodo/widgets/task_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  Future<void> pumpAnotherTodo(WidgetTester tester) async {
    await tester.pumpWidget(const AnotherTodo());
  }

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

  testWidgets("Should add todo and navigate back to home with a todo",
      (tester) async {
    //Arrange
    await pumpAnotherTodo(tester);
    await tester.pumpAndSettle();
    //Act
    await tester.tap(find.byKey(const Key("add-task-container-button")));
    await tester.pumpAndSettle();
    expect(find.byType(AddTaskScreen), findsOneWidget);
    await pickDate(
        tester, find.byKey(const Key("add_task_form_start_date_field")));
    await tester.pumpAndSettle();
    await pickDate(
        tester, find.byKey(const Key("add_task_form_end_date_field")));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const Key("add_task_form_title_field")), "Test Task");
    await tester.enterText(
        find.byKey(const Key("add_task_form_description_field")),
        "Test Description");
    await tester
        .tap(find.byKey(const Key("add_task_screen_bottom_app_bar_button")));
    await tester.pumpAndSettle();
    //Assert
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text("Test Task"), findsOneWidget);
    expect(find.text("Test Description"), findsOneWidget);
  });

  testWidgets("Should delete a todo", (tester) async {
    //Arrange
    await pumpAnotherTodo(tester);
    await tester.pumpAndSettle();
    //Act
    await tester.tap(find.byKey(const Key("add-task-container-button")));
    await tester.pumpAndSettle();
    expect(find.byType(AddTaskScreen), findsOneWidget);
    await pickDate(
        tester, find.byKey(const Key("add_task_form_start_date_field")));
    await tester.pumpAndSettle();
    await pickDate(
        tester, find.byKey(const Key("add_task_form_end_date_field")));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const Key("add_task_form_title_field")), "Test Task");
    await tester.enterText(
        find.byKey(const Key("add_task_form_description_field")),
        "Test Description");
    await tester
        .tap(find.byKey(const Key("add_task_screen_bottom_app_bar_button")));
    await tester.pumpAndSettle();
    expect(find.text("Test Task"), findsOneWidget);

    // Long press to show context menu
    final gesture =
        await tester.startGesture(tester.getCenter(find.byType(TaskWidget)));
    await tester.longPress(find.byType(TaskWidget));
    await tester.pump(const Duration(seconds: 3));
    await gesture.up();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("delete-task-context-menu-button")));
    await tester.pumpAndSettle();
    //Assert
    expect(find.text("Test Task"), findsNothing);
  });
}
