import 'package:freezed_annotation/freezed_annotation.dart';

part 'coordinates_dto.freezed.dart';
part 'coordinates_dto.g.dart';

@freezed
class CoordinatesDTO with _$CoordinatesDTO {
  const factory CoordinatesDTO({
    required double longitude,
    required double latitude,
  }) = _CoordinatesDTO;

  factory CoordinatesDTO.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesDTOFromJson(json);
}
