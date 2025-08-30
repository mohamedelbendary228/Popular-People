/// Custom exception used with Http requests
class AppException implements Exception {
  final String? title;
  final String? message;
  final int? statusCode;

  AppException({
    this.title,
    this.message,
    this.statusCode,
  });
}
