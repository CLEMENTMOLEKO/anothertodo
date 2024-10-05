import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anothertodo/common/enum_priority.dart' as TodoPriority;

/// {@template priority_cubit}
/// A [Cubit] which manages an [TodoPriority.Priority] as its state.
/// {@endtemplate}
class PriorityCubit extends Cubit<TodoPriority.Priority> {
  TodoPriority.Priority priority = TodoPriority.Priority.low;

  /// {@macro priority_cubit}
  PriorityCubit() : super(TodoPriority.Priority.low);

  /// A method that changes the state of [PriorityCubit] to value you provided.
  void changePriorityState(TodoPriority.Priority changedPriority) =>
      emit(changedPriority);
}
