import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils/task_bloc_test_utils.dart';

void main() {
  test("Should be equal when two instances with same values are compared", () {
    //Arrange
    final task = TaskBlocTestUtils.createTask();
    final state = TaskState(
      status: TaskStatus.success,
      tasks: [task],
    );

    final state2 = TaskState(
      status: TaskStatus.success,
      tasks: [task],
    );

    //Act
    //Assert
    expect(state, equals(state2));
  });

  test('TaskState should be serializable', () {
    //Arrange
    final state = TaskState(
      status: TaskStatus.success,
      tasks: [TaskBlocTestUtils.createTask()],
    );

    //Act
    final json = state.toJson();
    final deserializedState = TaskState.fromJson(json);

    //Assert
    expect(deserializedState, equals(state));
  });
}
