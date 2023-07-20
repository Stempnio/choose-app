import 'package:choose_app/data/data.dart';
import 'package:choose_app/data/service/places/places_service.dart';
import 'package:choose_app/domain/error/app_error.dart';
import 'package:choose_app/domain/model/places/place_entity.dart';
import 'package:choose_app/domain/repository/places_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PlacesRepository)
class PlacesRepositoryImpl implements PlacesRepository {
  const PlacesRepositoryImpl(this._service);

  final PlacesService _service;

  @override
  Future<Either<AppError, List<PlaceEntity>>> fetchPlaces({
    required String term,
    required double longitude,
    required double latitude,
  }) async {
    final placesDTO = await _service.fetchPlaces(
      term: term,
      longitude: longitude,
      latitude: latitude,
    );

    final placeEntities = placesDTO.map((place) => place.toEntity()).toList();

    return Right(placeEntities);
  }
}
