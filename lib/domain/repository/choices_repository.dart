import 'package:choose_app/domain/domain.dart';
import 'package:dartz/dartz.dart';

abstract class ChoicesRepository {
  Future<Either<AppError, ChoiceEntity>> drawChoice(List<ChoiceEntity> choices);

  Future<Either<AppError, List<ChoiceEntity>>> fetchPredefinedChoices({
    required String locale,
  });
}
