import 'package:choose_app/domain/model/choices/choices.dart';
import 'package:uuid/uuid.dart';

final choice1 = ChoiceEntity(
  name: 'Cinema',
  type: ChoiceType.place,
  instanceId: const Uuid().v4(),
  id: const Uuid().v4(),
);

final choice2 = ChoiceEntity(
  name: 'Park',
  type: ChoiceType.place,
  instanceId: const Uuid().v4(),
  id: const Uuid().v4(),
);

final choice3 = ChoiceEntity(
  name: 'Swimming',
  type: ChoiceType.activity,
  instanceId: const Uuid().v4(),
  id: const Uuid().v4(),
);

final choicesList = [choice1, choice2, choice3];
