import 'package:choose_app/data/data.dart';
import 'package:choose_app/domain/domain.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'choices_data.dart';

void main() {
  final choicesRepository = ChoicesRepositoryImpl();
  group('Choices Repository', () {
    test('drawChoice() returns a random choice from the list', () async {
      final result = await choicesRepository.drawChoice(choicesList);

      expect(
        result.fold(
          (l) => false,
          choicesList.contains,
        ),
        equals(true),
      );
    });

    test('drawChoice() returns Left when the list is empty', () async {
      final result = await choicesRepository.drawChoice([]);

      expect(
        result,
        isA<Left<AppError, ChoiceEntity>>(),
      );
    });
  });
}
