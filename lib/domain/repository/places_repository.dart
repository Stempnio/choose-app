import 'package:choose_app/domain/domain.dart';
import 'package:dartz/dartz.dart';

abstract class PlacesRepository {
  Future<Either<AppError, List<PlaceEntity>>> fetchPlaces({
    required String term,
    required double longitude,
    required double latitude,
  });
}
