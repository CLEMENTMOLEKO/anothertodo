import 'package:anothertodo/models/task.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState(status: TaskStatus.initial)) {
    on<Initial>(initialTask);
    on<TaskAdded>(onAddTask);
    on<TaskUpdated>(updateTask);
    on<TaskRemoved>(removeTask);
    on<TaskCompleted>(completeTask);
  }

  void initialTask(Initial event, Emitter<TaskState> emit) {
    if (state.status == TaskStatus.success) return;
    emit(state.copyWith(tasks: state.tasks, status: TaskStatus.success));
  }

  /// TODO: Introduce task service in packages to encapsulate the task logic. for all these methods.
  void onAddTask(TaskAdded event, Emitter<TaskState> emit) {
    emit(state.copyWith(status: TaskStatus.loading));

    if (state.tasks.any((task) => task.id == event.task.id)) {
      emit(state.copyWith(
          status: TaskStatus.failure, message: "Task already exists"));
      return;
    }

    List<Task> temp = <Task>[...state.tasks];
    Task tempTask = event.task.copyWith(id: const Uuid().v4().toString());

    temp.add(tempTask);
    emit(state.copyWith(status: TaskStatus.success, tasks: temp));
  }

  void updateTask(TaskUpdated event, Emitter<TaskState> emit) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      List<Task> temp = <Task>[...state.tasks];
      final taskToUpdate = _getTaskById(event.task.id);
      if (taskToUpdate == null) throw Exception("Task not found");

      temp.remove(taskToUpdate);
      temp.add(event.task);
      emit(state.copyWith(status: TaskStatus.success, tasks: temp));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.failure, message: e.toString()));
    }
  }

  void removeTask(TaskRemoved event, Emitter<TaskState> emit) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      List<Task> temp = <Task>[...state.tasks];
      final taskToRemove = _getTaskById(event.id);
      temp.remove(taskToRemove);

      emit(state.copyWith(status: TaskStatus.success, tasks: temp));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.failure, message: e.toString()));
    }
  }

  void completeTask(TaskCompleted event, Emitter<TaskState> emit) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      List<Task> temp = <Task>[...state.tasks];
      _getTaskById(event.id);

      temp.firstWhere((element) => element.id == event.id).toggleCompletTask();
      emit(state.copyWith(status: TaskStatus.success, tasks: temp));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.failure, message: e.toString()));
    }
  }

  /// throws an exception if the task is not found
  Task? _getTaskById(String id) {
    final task = state.tasks.firstWhere((task) => task.id == id);
    if (task.isEmpty) throw Exception("Task not found");
    return task;
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toJson();
  }
}
