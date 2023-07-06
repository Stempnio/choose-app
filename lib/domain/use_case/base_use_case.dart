import 'package:choose_app/domain/error/error.dart';
import 'package:dartz/dartz.dart';

class NoParams {}

abstract class BaseUseCase<Param, Response> {
  Future<Response> invoke(Param param);

  Future<Either<AppError, Response>> call(Param param) async {
    try {
      return Right(await invoke(param));
    } catch (_, __) {
      //@TODO: handle error
      return Left(AppError());
    }
  }
}
