import 'package:choose_app/domain/model/choices/choices.dart';

const choice1 = ChoiceEntity(
  name: 'Cinema',
  type: ChoiceType.place,
);
const choice2 = ChoiceEntity(
  name: 'Park',
  type: ChoiceType.place,
);
const choice3 = ChoiceEntity(
  name: 'Swimming',
  type: ChoiceType.activity,
);

const choicesList = [choice1, choice2, choice3];
