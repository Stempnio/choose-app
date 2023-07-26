import 'package:choose_app/l10n/l10n.dart';
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
        return context.l10n.choice_type__place;
      case ChoiceType.activity:
        return context.l10n.choice_type__activity;
      case ChoiceType.food:
        return context.l10n.choice_type__food;
      case ChoiceType.custom:
        return context.l10n.choice_type__custom;
    }
  }
}

String generateChoiceId() => const Uuid().v4();

@freezed
class ChoiceEntity with _$ChoiceEntity {
  const factory ChoiceEntity({
    required String id,
    required String instanceId,
    required String name,
    required ChoiceType type,
  }) = _ChoiceEntity;

  factory ChoiceEntity.empty() => ChoiceEntity(
        id: const Uuid().v4(),
        instanceId: const Uuid().v4(),
        name: '',
        type: ChoiceType.custom,
      );
}
