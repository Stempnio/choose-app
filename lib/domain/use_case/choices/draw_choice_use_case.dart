import 'package:choose_app/domain/domain.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DrawChoiceUseCase extends BaseUseCase<List<ChoiceEntity>, ChoiceEntity> {
  DrawChoiceUseCase(this._choicesRepository);

  final ChoicesRepository _choicesRepository;

  @override
  Future<Either<AppError, ChoiceEntity>> call(List<ChoiceEntity> param) =>
      _choicesRepository.drawChoice(param);
}
