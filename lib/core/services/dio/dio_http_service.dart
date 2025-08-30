import 'package:dio/dio.dart';
import 'package:popular_people/core/configs/app_configs.dart';
import 'package:popular_people/core/exceptions/app_exception.dart';
import 'package:popular_people/core/services/dio/dio_interceptors/dio_interceptor.dart';
import 'package:popular_people/core/services/dio/http_service.dart';

class DioHttpService implements HttpService {
  late final Dio dio;

  DioHttpService({
    Dio? dioOverride,
    bool enableCaching = true,
  }) {
    dio = dioOverride ?? Dio(baseOptions);
    if (enableCaching) {
      dio.interceptors.add(DioInterceptor());
    }
  }

  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => AppConfigs.baseUrl;

  @override
  Map<String, String> headers = {
    'accept': 'application/json',
    'content-type': 'application/json',
  };

  @override
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response<dynamic> response = await dio.get<Map<String, dynamic>>(
      endpoint,
      queryParameters: queryParameters,
    );

    if (response.data == null || response.statusCode != 200) {
      throw AppException(
        title: 'Dio Error!',
        statusCode: response.statusCode,
        message: response.statusMessage,
      );
    }
    return response.data as Map<String, dynamic>;
  }
}
