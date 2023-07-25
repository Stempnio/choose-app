import 'package:choose_app/data/model/choices/choices.dart';

abstract class ChoicesService {
  Future<List<ChoiceDTO>> fetchPredefinedChoices({
    required String locale,
  });
}
