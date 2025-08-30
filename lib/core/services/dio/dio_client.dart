abstract class DioClient {
  String get baseUrl;
  Map<String, String> get headers;

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });
}
