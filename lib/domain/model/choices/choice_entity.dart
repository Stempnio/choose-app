import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

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

  String str(BuildContext context) {
    switch (this) {
      case ChoiceType.place:
        return 'Place';
      case ChoiceType.activity:
        return 'Activity';
      case ChoiceType.food:
        return 'Food';
      case ChoiceType.custom:
        return 'Custom';
    }
  }
}

@freezed
class ChoiceEntity with _$ChoiceEntity {
  const factory ChoiceEntity({
    required String id,
    required String name,
    required ChoiceType type,
  }) = _ChoiceEntity;

  factory ChoiceEntity.empty() => ChoiceEntity(
        id: const Uuid().v1(),
        name: '',
        type: ChoiceType.place,
      );
}
