part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.choiceAdded(ChoiceEntity choice) = ChoiceAdded;
  const factory HomeEvent.choiceRemoved(ChoiceEntity choice) = ChoiceRemoved;
  const factory HomeEvent.choicesSubmitted() = ChoicesSubmitted;
}
