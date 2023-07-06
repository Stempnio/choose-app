import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.dart';
part 'splash_cubit.freezed.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.initializing());

  Future<void> init() async {
    await Future<void>.delayed(Duration.zero);

    emit(const SplashState.initialized());
  }
}
