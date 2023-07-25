import 'package:freezed_annotation/freezed_annotation.dart';

part 'choice_dto.freezed.dart';
part 'choice_dto.g.dart';

@freezed
class ChoiceDTO with _$ChoiceDTO {
  const factory ChoiceDTO({
    required String id,
    required String name,
    required String type,
  }) = _ChoiceDTO;

  factory ChoiceDTO.fromJson(Map<String, dynamic> json) =>
      _$ChoiceDTOFromJson(json);
}
