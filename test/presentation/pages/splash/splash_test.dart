import 'package:bloc_test/bloc_test.dart';
import 'package:choose_app/presentation/pages/pages.dart';
import 'package:test/test.dart';

void main() {
  group('SplashCubit', () {
    late SplashCubit splashCubit;

    setUp(() {
      splashCubit = SplashCubit();
    });

    tearDown(() {
      splashCubit.close();
    });

    test('initial state is SplashState.initializing()', () {
      expect(splashCubit.state, const SplashState.initializing());
    });

    blocTest<SplashCubit, SplashState>(
      'emits SplashState.initialized() after init method is called',
      build: () => splashCubit,
      act: (cubit) => cubit.init(),
      expect: () => [const SplashState.initialized()],
    );
  });
}
