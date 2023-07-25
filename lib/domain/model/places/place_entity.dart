import 'package:choose_app/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_entity.freezed.dart';

@freezed
class PlaceEntity with _$PlaceEntity {
  const factory PlaceEntity({
    required String name,
    required CoordinatesEntity coordinates,
    required double rating,
  }) = _PlaceEntity;
}
