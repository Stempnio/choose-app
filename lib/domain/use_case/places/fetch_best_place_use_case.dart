import 'package:choose_app/domain/domain.dart';
import 'package:choose_app/domain/model/places/place_entity.dart';
import 'package:choose_app/domain/use_case/places/typedefs.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchBestPlaceUseCase
    extends BaseUseCase<FetchPlacesParam, PlaceEntity?> {
  FetchBestPlaceUseCase(this._placesRepository);

  final PlacesRepository _placesRepository;

  @override
  Future<Either<AppError, PlaceEntity?>> call(FetchPlacesParam param) async {
    final places = await _placesRepository.fetchPlaces(
      term: param.term,
      longitude: param.longitude,
      latitude: param.latitude,
    );

    return places.fold(
      Left.new,
      (places) {
        if (places.isEmpty) return const Right(null);

        final highestRatedPlace = places.reduce(
          (highest, place) => place.rating > highest.rating ? place : highest,
        );
        return Right(highestRatedPlace);
      },
    );
  }
}
