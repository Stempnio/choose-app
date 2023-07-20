class NetworkException implements Exception {
  NetworkException({this.message = 'A network exception occurred.'});

  final String message;

  @override
  String toString() => 'NetworkException: $message';
}

class DecodingException implements Exception {
  DecodingException({this.message = 'Failed to decode data.'});

  final String message;

  @override
  String toString() => 'DecodingException: $message';
}
