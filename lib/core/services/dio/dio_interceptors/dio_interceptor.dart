import 'dart:convert';
import 'dart:developer';

import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/configs/app_configs.dart';
import 'package:popular_people/core/models/cache_response.dart';
import 'package:popular_people/core/services/cache/cache_service.dart';
import 'package:popular_people/features/popular_people/view/widgets/popular_people_list.dart';

class DioInterceptor extends Interceptor {
  final CacheService cacheService;
  final Ref ref;

  DioInterceptor(this.cacheService, {required this.ref});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('❌ ❌ ❌ Dio Error!');
    log('❌ ❌ ❌ Url: ${err.requestOptions.uri}');
    log('❌ ❌ ❌ ${err.stackTrace}');
    log('❌ ❌ ❌ Response Errors: ${err.response?.data}');
    final storageKey = createStorageKey(
      err.requestOptions.method,
      err.requestOptions.baseUrl,
      err.requestOptions.path,
      err.requestOptions.queryParameters,
    );

    if (cacheService.has(storageKey)) {
      final cachedResponse = _getCachedResponse(storageKey);
      if (cachedResponse != null) {
        log('📦 📦 📦 Retrieved response from cache');
        final response = cachedResponse.buildDioCacheResponse(err.requestOptions);
        log('⬅️ ⬅️ ⬅️ Response');
        log(
          '''
          <---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'}'
          ' ${response.requestOptions.baseUrl}${response.requestOptions.path}''',
        );
        log('Query params: ${response.requestOptions.queryParameters}');
        log('-------------------------');
        return handler.resolve(response);
      }
    }

    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra[AppConfigs.dioCacheForceRefreshKey] == true) {
      log('🌍 🌍 🌍 Retrieving request from network by force refresh');
      ref.read(isForceRefreshing.notifier).state = false;
      return handler.next(options);
    }
    final storageKey = createStorageKey(
      options.method,
      options.baseUrl,
      options.path,
      options.queryParameters,
    );
    if (cacheService.has(storageKey)) {
      final cachedResponse = _getCachedResponse(storageKey);
      if (cachedResponse != null) {
        log('📦 📦 📦 Retrieved response from cache');
        final response = cachedResponse.buildDioCacheResponse(options);
        log('⬅️ ⬅️ ⬅️ Response');
        log('<---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
        log('Query params: ${response.requestOptions.queryParameters}');

        log('-------------------------');
        return handler.resolve(response);
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final storageKey = createStorageKey(
      response.requestOptions.method,
      response.requestOptions.baseUrl,
      response.requestOptions.path,
      response.requestOptions.queryParameters,
    );

    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      log('🌍 🌍 🌍 Retrieved response from network');
      log('⬅️ ⬅️ ⬅️ Response');
      log('<---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      log('Query params: ${response.requestOptions.queryParameters}');
      log('-------------------------');

      final cachedResponse = CachedResponse(
        data: response.data,
        headers: Headers.fromMap(response.headers.map),
        age: clock.now(),
        statusCode: response.statusCode!,
      );
      cacheService.set(storageKey, cachedResponse.toJson());
    }
    return handler.next(response);
  }

  String createStorageKey(
    String method,
    String baseUrl,
    String path, [
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  ]) {
    var storageKey = '${method.toUpperCase()}:${baseUrl + path}/';
    if (queryParameters.isNotEmpty) {
      storageKey += '?';
      queryParameters.forEach((key, dynamic value) {
        storageKey += '$key=$value&';
      });
    }
    return storageKey;
  }

  CachedResponse? _getCachedResponse(String storageKey) {
    final dynamic rawCachedResponse = cacheService.get(storageKey);
    try {
      final cachedResponse = CachedResponse.fromJson(
        json.decode(json.encode(rawCachedResponse)) as Map<String, dynamic>,
      );
      if (cachedResponse.isValid) {
        return cachedResponse;
      } else {
        log('Cache is outdated, deleting it...');
        cacheService.remove(storageKey);
        return null;
      }
    } catch (e) {
      log('Error retrieving response from cache');
      log('e: $e');
      return null;
    }
  }
}
