import 'package:anothertodo/common/enum_priority.dart';
import 'package:anothertodo/models/task.dart';
import 'package:uuid/uuid.dart';

class TaskBlocTestUtils {
  static final taskId = const Uuid().v4().toString();

  static Task createTask({String? name, bool isComplete = false}) {
    return Task(
      title: name ?? 'Test Task',
      description: 'Test Description',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      priority: Priority.low,
      id: taskId,
      isComplete: isComplete,
    );
  }
}
