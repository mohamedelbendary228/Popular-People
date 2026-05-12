import 'package:popular_people/core/services/dio/dio_client_impl.dart';

abstract class DioClient {
  String get baseUrl;
  Map<String, String> get headers;

  Future<T> get<T>(
    String endpoint, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
    bool isIsolate = false,
  });
}
