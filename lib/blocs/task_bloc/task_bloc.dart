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
    on<AddTask>(onAddTask);
    on<UpdateTask>(updateTask);
    on<RemoveTask>(removeTask);
    on<CompleteTask>(completeTask);
  }

  void initialTask(Initial event, Emitter<TaskState> emit) {
    if (state.status == TaskStatus.success) return;
    emit(state.copyWith(tasks: state.tasks, status: TaskStatus.success));
  }

  void onAddTask(AddTask event, Emitter<TaskState> emit) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      List<Task> temp = <Task>[];
      Task tempTask = event.task.copyWith(id: const Uuid().v4().toString());
      temp.addAll(state.tasks);
      temp.add(tempTask);
      emit(state.copyWith(status: TaskStatus.success, tasks: temp));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.failure, message: e.toString()));
    }
  }

  void updateTask(UpdateTask event, Emitter<TaskState> emit) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      List<Task> temp = <Task>[];
      temp.addAll(state.tasks);
      temp.add(event.task);
      emit(state.copyWith(status: TaskStatus.success, tasks: temp));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.failure, message: e.toString()));
    }
  }

  void removeTask(RemoveTask event, Emitter<TaskState> emit) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      List<Task> temp = <Task>[];
      temp.addAll(state.tasks);
      temp.remove(state.tasks.firstWhere((element) => element.id == event.id));
      emit(state.copyWith(status: TaskStatus.success, tasks: temp));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.failure, message: e.toString()));
    }
  }

  void completeTask(CompleteTask event, Emitter<TaskState> emit) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      List<Task> temp = <Task>[];
      temp.addAll(state.tasks);
      temp.firstWhere((element) => element.id == event.id).toggleCompletTask();
      emit(state.copyWith(status: TaskStatus.success, tasks: temp));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.failure, message: e.toString()));
    }
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
