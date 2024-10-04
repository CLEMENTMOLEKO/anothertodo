part of 'task_bloc.dart';

@immutable
sealed class TaskEvent extends Equatable {
  const TaskEvent();
}

class Initial extends TaskEvent {
  @override
  List<Object?> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;
  const AddTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class RemoveTask extends TaskEvent {
  final String id;

  const RemoveTask({required this.id});

  @override
  List<Object?> get props => [id];
}

class CompleteTask extends TaskEvent {
  final String id;

  const CompleteTask({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
