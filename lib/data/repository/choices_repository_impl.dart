import 'dart:math';
import 'package:choose_app/data/mapper/mapper.dart';
import 'package:choose_app/data/service/choices/choices_service.dart';
import 'package:choose_app/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChoicesRepository)
class ChoicesRepositoryImpl implements ChoicesRepository {
  ChoicesRepositoryImpl(this._service);

  final ChoicesService _service;

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
  Future<Either<AppError, List<ChoiceEntity>>> fetchPredefinedChoices({
    required String locale,
  }) async {
    try {
      final choiceDTOs = await _service.fetchPredefinedChoices(locale: locale);

      final result =
          choiceDTOs.map((choiceDTO) => choiceDTO.toEntity()).toList();

      return Right(result);
    } catch (_) {
      return Left(AppError());
    }
  }
}
