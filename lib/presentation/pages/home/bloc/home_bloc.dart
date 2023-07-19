import 'package:bloc/bloc.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:choose_app/domain/use_case/draw_choice_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._drawChoiceUseCase)
      : super(const HomeState.success(predefinedChoices: _mockChoices)) {
    on<HomeEvent>((event, emit) {
      switch (event) {
        case ChoiceAdded(:final choice):
          _onChoiceAdded(choice, emit);
        case ChoiceRemoved(:final choice):
          _onChoiceRemoved(choice, emit);
        case ChoicesSubmitted():
          _onChoicesSubmitted(emit);
      }
    });
  }

  final DrawChoiceUseCase _drawChoiceUseCase;

  Future<void> _onChoiceAdded(
    ChoiceEntity choice,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSuccessState) return;

    final successState = state as HomeSuccessState;

    emit(
      successState.copyWith(userChoices: [...successState.userChoices, choice]),
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
}

const _mockChoices = [
  ChoiceEntity(id: '1', name: 'first', type: ChoiceType.place),
  ChoiceEntity(id: '2', name: 'second', type: ChoiceType.place),
  ChoiceEntity(id: '3', name: 'third', type: ChoiceType.place),
  ChoiceEntity(id: '4', name: 'fourth', type: ChoiceType.place),
  ChoiceEntity(id: '5', name: 'fifth', type: ChoiceType.place),
];
