import 'package:choose_app/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchPredefinedChoiceUseCase
    extends BaseUseCase<String, List<ChoiceEntity>> {
  FetchPredefinedChoiceUseCase(this._choicesRepository);

  final ChoicesRepository _choicesRepository;

  @override
  Future<Either<AppError, List<ChoiceEntity>>> call(String param) =>
      _choicesRepository.fetchPredefinedChoices(locale: param);
}
