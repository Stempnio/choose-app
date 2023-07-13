import 'package:choose_app/domain/error/error.dart';
import 'package:dartz/dartz.dart';

class NoParams {}

abstract class BaseUseCase<Param, Response> {
  Future<Either<AppError, Response>> call(Param param);
}
