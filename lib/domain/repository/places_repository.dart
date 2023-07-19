import 'package:choose_app/domain/error/app_error.dart';
import 'package:choose_app/domain/model/places/places.dart';
import 'package:dartz/dartz.dart';

abstract class PlacesRepository {
  Future<Either<AppError, List<PlaceEntity>>> fetchPlaces({
    required String longitude,
    required String latitude,
  });
}
