import 'package:bloc/bloc.dart';

/// {@template bottom_bar_cubit}
/// A [Cubit] which manages the selected bottom bar item(index), uses [int] as its state.
/// {@endtemplate}
class BottomBarCubit extends Cubit<int> {
  BottomBarCubit() : super(0);

  /// A method that changes the state of [BottomBarCubit] to [int] value you provided.
  void setIndex(int index) => emit(index);
}
