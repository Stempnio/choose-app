import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_entity.freezed.dart';

@freezed
class PlaceEntity with _$PlaceEntity {
  const factory PlaceEntity({
    required String name,
    required String latitude,
    required String longitude,
    required int rating,
  }) = _PlaceEntity;
}
