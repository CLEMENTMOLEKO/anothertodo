import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:anothertodo/common/enum_priority.dart';
import 'package:anothertodo/models/task.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  late TaskBloc taskBloc;
  late MockStorage storage;

  void initHydratedStorage() {
    TestWidgetsFlutterBinding.ensureInitialized();
    storage = MockStorage();
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  }

  initHydratedStorage();

  setUp(() {
    taskBloc = TaskBloc();
  });

  group('TaskBloc', () {
    test('initial state is correct', () {
      expect(taskBloc.state, equals(TaskState(status: TaskStatus.initial)));
    });

    group("TaskAdded", () {
      final addedTask = Task(
        title: 'Test Task',
        description: 'Test Description',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        priority: Priority.low,
        id: '1',
      );

      blocTest(
        'emits [TaskState(status: TaskStatus.loading), TaskState(status: TaskStatus.success, tasks: addedTasks)] when TaskAdded is added',
        build: () => taskBloc,
        act: (bloc) => bloc.add(TaskAdded(task: addedTask)),
        expect: () => [
          TaskState(status: TaskStatus.loading),
          TaskState(status: TaskStatus.success, tasks: [addedTask]),
        ],
      );
    });
  });
}
