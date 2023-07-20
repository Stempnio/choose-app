import 'package:freezed_annotation/freezed_annotation.dart';

part 'coordinates_entity.freezed.dart';

@freezed
class CoordinatesEntity with _$CoordinatesEntity {
  const factory CoordinatesEntity({
    required String latitude,
    required String longitude,
  }) = _CoordinatesEntity;
}
