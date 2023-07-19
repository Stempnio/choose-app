import 'package:choose_app/domain/domain.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ChoicesRepository {
  Future<Either<AppError, ChoiceEntity>> drawChoice(List<ChoiceEntity> choices);

  Future<Either<AppError, List<ChoiceEntity>>> getPredefinedChoices(
    ChoiceType type,
  );
}
