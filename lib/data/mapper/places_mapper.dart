import 'package:choose_app/data/model/places/coordinates_dto.dart';
import 'package:choose_app/data/model/places/place_dto.dart';
import 'package:choose_app/domain/model/places/places.dart';

extension PlacesMapper on PlaceDTO {
  PlaceEntity toEntity() => PlaceEntity(
        name: name,
        coordinates: coordinates.toEntity(),
        rating: rating,
      );
}

extension CoordinatesMapper on CoordinatesDTO {
  CoordinatesEntity toEntity() => CoordinatesEntity(
        latitude: latitude,
        longitude: longitude,
      );
}
