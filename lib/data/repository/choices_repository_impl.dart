import 'dart:math';

import 'package:choose_app/domain/domain.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:injectable/injectable.dart';

class NoChoicesGivenException implements Exception {}

@Injectable(as: ChoicesRepository)
class ChoicesRepositoryImpl implements ChoicesRepository {
  @override
  Future<ChoiceEntity> drawChoice(List<ChoiceEntity> choices) async {
    if (choices.isEmpty) throw NoChoicesGivenException();

    final randomIndex = Random().nextInt(choices.length);

    return choices[randomIndex];
  }

  @override
  Future<List<ChoiceEntity>> getPredefinedChoices(ChoiceType type) {
    //@TODO: implement getChoicesByType
    throw UnimplementedError();
  }
}
