part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.success({
    @Default([]) List<ChoiceEntity> userChoices,
    @Default([]) List<ChoiceEntity> predefinedChoices,
    ChoiceEntity? selectedChoice,
  }) = HomeSuccessState;
  const factory HomeState.error() = _Error;
}
