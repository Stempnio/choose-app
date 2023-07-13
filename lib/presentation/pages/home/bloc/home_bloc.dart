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
  HomeBloc(this._drawChoiceUseCase) : super(const HomeState.success()) {
    on<HomeEvent>((event, emit) {
      event.when(
        choiceAdded: (choice) => _onChoiceAdded(choice, emit),
        choiceRemoved: (choice) => _onChoiceRemoved(choice, emit),
        choicesSubmitted: () => _onChoicesSubmitted(emit),
      );
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
