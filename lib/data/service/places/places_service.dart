import 'package:choose_app/data/data.dart';

abstract class PlacesService {
  Future<List<PlaceDTO>> fetchPlaces({
    required String term,
    required double longitude,
    required double latitude,
  });
}
