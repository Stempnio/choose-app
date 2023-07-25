import 'package:choose_app/data/model/choices/choice_dto.dart';
import 'package:choose_app/data/service/choices/choices_service.dart';
import 'package:choose_app/data/service/choices/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

const _choicesCollection = 'choices';
const _itemsCollection = 'items';

@Injectable(as: ChoicesService)
class ChoicesServiceImpl implements ChoicesService {
  final db = FirebaseFirestore.instance;

  @override
  Future<List<ChoiceDTO>> fetchPredefinedChoices({
    required String locale,
  }) async {
    try {
      final categories = await _fetchCategories();

      final choices = <ChoiceDTO>[];

      for (final category in categories) {
        final categoryChoices = await _fetchCategoryItems(
          categoryId: category.id,
          categoryName: category.name,
          locale: locale,
        );

        choices.addAll(categoryChoices);
      }

      return choices;
    } catch (e) {
      throw FetchChoicesException();
    }
  }

  Future<List<({String id, String name})>> _fetchCategories() async {
    final categories = <({String id, String name})>[];

    final snapshot = await db.collection(_choicesCollection).get();

    for (final doc in snapshot.docs) {
      categories.add((id: doc.id, name: doc['categoryName'] as String));
    }

    return categories;
  }

  Future<List<ChoiceDTO>> _fetchCategoryItems({
    required String categoryId,
    required String categoryName,
    required String locale,
  }) async {
    final itemsSnapshot = await db
        .collection(_choicesCollection)
        .doc(categoryId)
        .collection(_itemsCollection)
        .get();

    final items = itemsSnapshot.docs
        .map(
          (doc) => ChoiceDTO(
            id: doc.id,
            name: doc[locale] as String,
            type: categoryName,
          ),
        )
        .toList();

    return items;
  }
}
