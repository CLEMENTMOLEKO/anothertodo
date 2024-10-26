part of 'task_bloc.dart';

enum TaskStatus { loading, success, failure, initial }

class TaskState extends Equatable {
  final TaskStatus status;
  final List<Task> tasks;
  final String? message;

  const TaskState({
    this.status = TaskStatus.initial,
    this.tasks = const [],
    this.message,
  });

  @override
  List<Object?> get props => [status, tasks];

  TaskState copyWith({TaskStatus? status, List<Task>? tasks, String? message}) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      message: message ?? this.message,
    );
  }

  factory TaskState.fromJson(Map<String, dynamic> json) {
    List<Task> taskList = (json["tasks"] as List<Map<String, dynamic>>)
        .map((task) => Task.fromJson(task))
        .toList();

    return TaskState(
      status: TaskStatus.values
          .firstWhere((element) => element.name == json["status"]),
      tasks: taskList,
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status.name,
      "tasks": tasks.map((task) => task.toJson()).toList(),
      "message": message
    };
  }
}
