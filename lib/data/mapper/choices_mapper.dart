import 'package:choose_app/data/data.dart';
import 'package:choose_app/domain/domain.dart';

extension ChoiceMapper on ChoiceDTO {
  ChoiceEntity toEntity() => ChoiceEntity(
        id: id,
        instanceId: generateChoiceId(),
        name: name,
        type: _mapChoiceType(type),
      );
}

ChoiceType _mapChoiceType(String type) {
  switch (type) {
    case 'place':
      return ChoiceType.place;
    case 'activity':
      return ChoiceType.activity;
    case 'food':
      return ChoiceType.food;
    default:
      throw Exception('Unknown choice type: $type');
  }
}
