import 'package:choose_app/domain/model/choices/choice_entity.dart';

abstract class ChoicesRepository {
  Future<ChoiceEntity> drawChoice(List<ChoiceEntity> choices);

  Future<List<ChoiceEntity>> getPredefinedChoices(ChoiceType type);
}
