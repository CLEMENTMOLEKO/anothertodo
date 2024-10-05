part of 'task_bloc.dart';

@immutable
sealed class TaskEvent extends Equatable {
  const TaskEvent();
}

class Initial extends TaskEvent {
  @override
  List<Object?> get props => [];
}

class TaskAdded extends TaskEvent {
  final Task task;
  const TaskAdded({required this.task});

  @override
  List<Object?> get props => [task];
}

class TaskUpdated extends TaskEvent {
  final Task task;

  const TaskUpdated({required this.task});

  @override
  List<Object?> get props => [task];
}

class TaskRemoved extends TaskEvent {
  final String id;

  const TaskRemoved({required this.id});

  @override
  List<Object?> get props => [id];
}

class TaskCompleted extends TaskEvent {
  final String id;

  const TaskCompleted({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
