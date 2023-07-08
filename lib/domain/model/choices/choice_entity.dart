import 'package:freezed_annotation/freezed_annotation.dart';

part 'choice_entity.freezed.dart';

enum ChoiceType {
  place,
  activity,
  food,
  custom;

  bool get isPlace => this == ChoiceType.place;
  bool get isActivity => this == ChoiceType.activity;
  bool get isFood => this == ChoiceType.food;
  bool get isCustom => this == ChoiceType.custom;
}

@freezed
class ChoiceEntity with _$ChoiceEntity {
  const factory ChoiceEntity({
    required String name,
    required ChoiceType type,
  }) = _ChoiceEntity;
}
