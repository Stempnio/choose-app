import 'dart:convert';
import 'dart:io';

import 'package:choose_app/data/model/places/place_dto.dart';
import 'package:choose_app/data/service/places/places_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

const _baseUrl = 'api.yelp.com';
const _placesEndpoint = '/v3/businesses/search';

@Injectable(as: PlacesService)
class PlacesServiceImpl implements PlacesService {
  @override
  Future<List<PlaceDTO>> fetchPlaces({
    required String term,
    required double longitude,
    required double latitude,
  }) async {
    final queryParams = {
      'term': term,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };

    final apiKey = dotenv.get('YELP_API_KEY');

    final uri = Uri.https(_baseUrl, _placesEndpoint, queryParams);

    final headers = {HttpHeaders.authorizationHeader: 'Bearer $apiKey'};

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

      final placesJson = responseJson['businesses'] as List<dynamic>;

      final places = placesJson
          .map(
            (placeJson) => PlaceDTO.fromJson(placeJson as Map<String, dynamic>),
          )
          .toList();

      return places;
    } else {
      throw Exception('Failed to load places');
    }
  }
}
