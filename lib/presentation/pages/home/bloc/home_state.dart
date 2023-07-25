part of 'home_bloc.dart';

enum DrawStatus {
  initial,
  pending,
  success,
  error;

  bool get isPending => this == DrawStatus.pending;
  bool get isSuccess => this == DrawStatus.success;
  bool get isError => this == DrawStatus.error;
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.success({
    @Default([]) List<ChoiceEntity> userChoices,
    @Default([]) List<ChoiceEntity> predefinedChoices,
    ChoiceEntity? selectedChoice,
    PlaceEntity? suggestedPlace,
    Position? userLocation,
    @Default(DrawStatus.initial) DrawStatus status,
  }) = HomeSuccessState;
  const factory HomeState.error() = _Error;
}
