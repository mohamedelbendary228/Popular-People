import 'package:dio/dio.dart';
import 'package:popular_people/core/configs/app_configs.dart';
import 'package:popular_people/core/exceptions/app_exception.dart';
import 'package:popular_people/core/services/cache/cache_service.dart';
import 'package:popular_people/core/services/dio/dio_interceptors/dio_interceptor.dart';
import 'package:popular_people/core/services/dio/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioClientImpl implements DioClient {
  late final Dio dio;

  final CacheService cacheService;
  final Ref ref;

  DioClientImpl({
    required this.cacheService,
    required this.ref,
    Dio? dioOverride,
    bool enableCaching = true,
  }) {
    dio = dioOverride ?? Dio(baseOptions);
    if (enableCaching) {
      dio.interceptors.add(DioInterceptor(cacheService, ref: ref));
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
    bool forceRefresh = false,
  }) async {
    dio.options.extra[AppConfigs.dioCacheForceRefreshKey] = forceRefresh;

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
