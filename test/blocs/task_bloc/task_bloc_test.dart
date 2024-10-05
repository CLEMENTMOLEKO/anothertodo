import 'package:anothertodo/blocs/task_bloc/task_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

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
  });
}
