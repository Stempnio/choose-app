import 'package:choose_app/data/model/places/coordinates_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_dto.freezed.dart';
part 'place_dto.g.dart';

@freezed
class PlaceDTO with _$PlaceDTO {
  const factory PlaceDTO({
    required String name,
    required CoordinatesDTO coordinates,
    required double rating,
  }) = _PlaceDTO;

  factory PlaceDTO.fromJson(Map<String, dynamic> json) =>
      _$PlaceDTOFromJson(json);
}
