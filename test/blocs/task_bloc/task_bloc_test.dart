import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:anothertodo/common/enum_priority.dart';
import 'package:anothertodo/models/task.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'test_utils/task_bloc_test_utils.dart';

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
      final addedTask = TaskBlocTestUtils.createTask();

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

    group("TaskUpdated", () {
      final taskToUpdate = TaskBlocTestUtils.createTask(name: "task to update");
      final updatedTask = TaskBlocTestUtils.createTask();

      blocTest(
        'emits [TaskState(status: TaskStatus.loading, tasks: [taskToUpdate]), TaskState(status: TaskStatus.success, tasks: [updatedTask])] when Task is updated',
        build: () => taskBloc,
        seed: () =>
            TaskState(status: TaskStatus.success, tasks: [taskToUpdate]),
        act: (bloc) => bloc.add(TaskUpdated(task: updatedTask)),
        expect: () => [
          TaskState(status: TaskStatus.loading, tasks: [taskToUpdate]),
          TaskState(status: TaskStatus.success, tasks: [updatedTask]),
        ],
      );

      blocTest(
        'emits [TaskState(status: TaskStatus.loading), TaskState(status: TaskStatus.failure, message: "Task not found")] when Task is not found',
        build: () => taskBloc,
        act: (bloc) => bloc.add(TaskUpdated(task: updatedTask)),
        expect: () => [
          TaskState(status: TaskStatus.loading),
          TaskState(status: TaskStatus.failure, message: "Task not found"),
        ],
      );
    });

    group("TaskRemoved", () {
      final taskToRemove = TaskBlocTestUtils.createTask();

      blocTest(
        'emits [TaskState(status: TaskStatus.loading), TaskState(status: TaskStatus.success, tasks: [])] when Task is removed',
        build: () => taskBloc,
        seed: () =>
            TaskState(status: TaskStatus.success, tasks: [taskToRemove]),
        act: (bloc) => bloc.add(TaskRemoved(id: taskToRemove.id)),
        expect: () => [
          TaskState(status: TaskStatus.loading, tasks: [taskToRemove]),
          TaskState(status: TaskStatus.success, tasks: []),
        ],
      );

      blocTest(
        'emits [TaskState(status: TaskStatus.loading), TaskState(status: TaskStatus.failure, message: "Task not found")] when Task is not found',
        build: () => taskBloc,
        act: (bloc) => bloc.add(TaskRemoved(id: taskToRemove.id)),
        expect: () => [
          TaskState(status: TaskStatus.loading),
          TaskState(status: TaskStatus.failure, message: "Task not found"),
        ],
      );
    });

    group("TaskCompleted", () {
      final taskToComplete = TaskBlocTestUtils.createTask(isComplete: false);

      blocTest(
        'emits [TaskState(status: TaskStatus.loading), TaskState(status: TaskStatus.success, tasks: [taskToComplete])] when Task is completed',
        build: () => taskBloc,
        seed: () =>
            TaskState(status: TaskStatus.success, tasks: [taskToComplete]),
        act: (bloc) => bloc.add(TaskCompleted(id: taskToComplete.id)),
        expect: () => [
          TaskState(status: TaskStatus.loading, tasks: [taskToComplete]),
          TaskState(
            status: TaskStatus.success,
            tasks: [taskToComplete],
          ),
        ],
        verify: (bloc) {
          expect(bloc.state.tasks.first.isComplete, isTrue);
        },
      );

      blocTest(
        'emits [TaskState(status: TaskStatus.loading), TaskState(status: TaskStatus.failure, message: "Task not found")] when Task is not found',
        build: () => taskBloc,
        act: (bloc) => bloc.add(TaskCompleted(id: taskToComplete.id)),
        expect: () => [
          TaskState(status: TaskStatus.loading),
          TaskState(
            status: TaskStatus.failure,
            message: "Task not found",
          ),
        ],
      );
    });
  });
}
