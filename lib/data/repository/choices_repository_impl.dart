import 'dart:math';

import 'package:choose_app/domain/domain.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

class NoChoicesGivenException implements Exception {}

@Injectable(as: ChoicesRepository)
class ChoicesRepositoryImpl implements ChoicesRepository {
  @override
  Future<Either<AppError, ChoiceEntity>> drawChoice(
    List<ChoiceEntity> choices,
  ) async {
    if (choices.isEmpty) {
      return Left(AppError());
    }

    final randomIndex = Random().nextInt(choices.length);

    return Right(choices[randomIndex]);
  }

  @override
  Future<Either<AppError, List<ChoiceEntity>>> getPredefinedChoices(
    ChoiceType type,
  ) {
    //@TODO: implement getChoicesByType
    throw UnimplementedError();
  }
}
