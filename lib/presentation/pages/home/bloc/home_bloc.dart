import 'package:bloc/bloc.dart';
import 'package:choose_app/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this._drawChoiceUseCase,
    this._fetchBestPlaceUseCase,
    this._fetchChoices,
  ) : super(const HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      switch (event) {
        case ChoiceAdded(:final choice):
          await _onChoiceAdded(choice, emit);
        case ChoiceRemoved(:final choice):
          await _onChoiceRemoved(choice, emit);
        case ChoicesSubmitted():
          await _onChoicesSubmitted(emit);
        case ChoicesReset():
          _onChoicesReset(emit);
        case PredefinedChoicesFetched(:final locale):
          await _onPredefinedChoicesFetched(locale, emit);
      }
    });
  }

  final DrawChoiceUseCase _drawChoiceUseCase;
  final FetchBestPlaceUseCase _fetchBestPlaceUseCase;
  final FetchPredefinedChoiceUseCase _fetchChoices;

  Future<void> init({required String locale}) async {
    add(HomeEvent.predefinedChoicesFetched(locale: locale));
  }

  Future<void> _onPredefinedChoicesFetched(
    String locale,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());

    final choicesResult = await _fetchChoices(locale);

    choicesResult.fold(
      (error) => emit(const HomeState.error()),
      (choices) => emit(HomeState.success(predefinedChoices: choices)),
    );
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

    emit(successState.copyWith(status: DrawStatus.pending));

    final choiceResult = await _drawChoiceUseCase(successState.userChoices);

    ChoiceEntity? selectedChoice;

    choiceResult.fold(
      (error) => emit(const HomeState.error()),
      (choice) => selectedChoice = choice,
    );

    if (selectedChoice == null) return;

    final userLocation = await _determineUserPosition();

    if (userLocation == null) {
      return emit(
        successState.copyWith(
          selectedChoice: selectedChoice,
          status: DrawStatus.success,
          isLocationPermissionGranted: false,
          userLocation: null,
          suggestedPlace: null,
        ),
      );
    }

    final suggestedPlace = await _getBestPlace(selectedChoice!, userLocation);

    emit(
      successState.copyWith(
        selectedChoice: selectedChoice,
        suggestedPlace: suggestedPlace,
        userLocation: userLocation,
        status: DrawStatus.success,
        isLocationPermissionGranted: true,
      ),
    );
  }

  Future<PlaceEntity?> _getBestPlace(
    ChoiceEntity choice,
    Position userPosition,
  ) async {
    PlaceEntity? bestPlace;

    final bestPlaceResult = await _fetchBestPlaceUseCase(
      (
        term: choice.name,
        longitude: userPosition.longitude,
        latitude: userPosition.latitude,
      ),
    );

    bestPlaceResult.fold((_) => null, (place) => bestPlace = place);

    return bestPlace;
  }

  void _onChoicesReset(Emitter<HomeState> emit) {
    if (state is! HomeSuccessState) return;

    final successState = state as HomeSuccessState;

    emit(
      successState.copyWith(userChoices: [], selectedChoice: null),
    );
  }

  Future<bool> _requestPermissions() async =>
      Permission.location.request().isGranted;

  Future<Position?> _determineUserPosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) return null;

      final permissionsGranted = await _requestPermissions();

      if (!permissionsGranted) return null;

      final position = await Geolocator.getCurrentPosition();

      return position;
    } catch (_) {
      return null;
    }
  }
}
