import 'package:choose_app/data/data.dart';
import 'package:test/test.dart';
import 'choices_data.dart';

void main() {
  final choicesRepository = ChoicesRepositoryImpl();
  group('Choices Repository', () {
    test('drawChoice() returns a random choice from the list', () async {
      final choice = await choicesRepository.drawChoice(choicesList);

      expect(choicesList.contains(choice), true);
    });

    test('drawChoice() throws NoChoicesGivenException when the list is empty',
        () async {
      expect(
        choicesRepository.drawChoice([]),
        throwsA(isA<NoChoicesGivenException>()),
      );
    });
  });
}
