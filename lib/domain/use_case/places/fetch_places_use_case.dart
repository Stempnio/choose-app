import 'package:choose_app/domain/domain.dart';
import 'package:choose_app/domain/use_case/places/typedefs.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchPlacesUseCase
    extends BaseUseCase<FetchPlacesParam, List<PlaceEntity>> {
  FetchPlacesUseCase(this._placesRepository);

  final PlacesRepository _placesRepository;

  @override
  Future<Either<AppError, List<PlaceEntity>>> call(FetchPlacesParam param) =>
      _placesRepository.fetchPlaces(
        term: param.term,
        longitude: param.longitude,
        latitude: param.latitude,
      );
}
