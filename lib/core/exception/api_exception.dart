class ApiException implements Exception {
  ApiException(this.message, {this.statusCode, this.body, this.cause});
  final String message;
  final int? statusCode;
  final String? body;
  final Object? cause;
  @override
  String toString() => 'ApiException(status: $statusCode, message: $message)';
}
