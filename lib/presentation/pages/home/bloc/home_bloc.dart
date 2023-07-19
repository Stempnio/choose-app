import 'package:bloc/bloc.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:choose_app/domain/use_case/draw_choice_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._drawChoiceUseCase)
      : super(HomeState.success(predefinedChoices: _mockChoices)) {
    on<HomeEvent>((event, emit) {
      switch (event) {
        case ChoiceAdded(:final choice):
          _onChoiceAdded(choice, emit);
        case ChoiceRemoved(:final choice):
          _onChoiceRemoved(choice, emit);
        case ChoicesSubmitted():
          _onChoicesSubmitted(emit);
        case ChoicesReset():
          _onChoicesReset(emit);
      }
    });
  }

  final DrawChoiceUseCase _drawChoiceUseCase;

  Future<void> init() async {
    await _requestPermissions();
  }

  Future<void> _onChoiceAdded(
    ChoiceEntity choice,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSuccessState) return;

    final successState = state as HomeSuccessState;

    final uniqueChoice = choice.copyWith(instanceId: const Uuid().v4());

    emit(
      successState.copyWith(
        userChoices: [
          ...successState.userChoices,
          uniqueChoice,
        ],
      ),
    );
  }

  Future<void> _onChoiceRemoved(
    ChoiceEntity removedChoice,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSuccessState) return;

    final successState = state as HomeSuccessState;

    final filteredChoices = successState.userChoices
        .where((choice) => choice != removedChoice)
        .toList();

    emit(
      successState.copyWith(userChoices: filteredChoices),
    );
  }

  Future<void> _onChoicesSubmitted(
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSuccessState) return;

    final successState = state as HomeSuccessState;

    final choiceResult = await _drawChoiceUseCase(successState.userChoices);

    choiceResult.fold(
      (error) => emit(const HomeState.error()),
      (choice) => emit(
        successState.copyWith(selectedChoice: choice),
      ),
    );
  }

  void _onChoicesReset(Emitter<HomeState> emit) {
    if (state is! HomeSuccessState) return;

    final successState = state as HomeSuccessState;

    emit(
      successState.copyWith(userChoices: [], selectedChoice: null),
    );
  }

  Future<bool> _requestPermissions() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) return false;

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    return true;
  }

  Future<Position?> _determinePosition() async {
    final permissionsGranted = await _requestPermissions();

    if (!permissionsGranted) return null;

    return Geolocator.getCurrentPosition();
  }
}

final _mockChoices = List.generate(
  50,
  (index) => ChoiceEntity.empty().copyWith(name: 'Choice $index'),
);
