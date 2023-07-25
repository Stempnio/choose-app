class FetchChoicesException implements Exception {
  FetchChoicesException({this.message = 'Failed to fetch choices.'});

  final String message;

  @override
  String toString() => 'FetchChoicesException: $message';
}
