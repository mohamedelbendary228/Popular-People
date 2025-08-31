import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:popular_people/core/configs/app_configs.dart';

class CachedResponse {
  final dynamic data;

  /// The age of the cached response
  /// This is used to determine whether the cache has expired or not
  /// based on the [Configs.maxCacheAge] value
  final DateTime age;

  final int statusCode;

  final Headers headers;

  CachedResponse({
    required this.data,
    required this.age,
    required this.statusCode,
    required this.headers,
  });

  /// Determines if a cached response has expired
  bool get isValid => clock.now().isBefore(age.add(AppConfigs.maxCacheAge));

  factory CachedResponse.fromJson(Map<String, dynamic> data) {
    return CachedResponse(
      data: data['data'],
      age: DateTime.parse(data['age'] as String),
      statusCode: data['statusCode'] as int,
      headers: Headers.fromMap(
        Map<String, List<dynamic>>.from(
          json.decode(json.encode(data['headers'])) as Map<dynamic, dynamic>,
        ).map(
          (k, v) => MapEntry(k, List<String>.from(v)),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data': data,
      'age': age.toString(),
      'statusCode': statusCode,
      'headers': headers.map,
    };
  }

  Response<dynamic> buildDioCacheResponse(RequestOptions options) {
    return Response<dynamic>(
      data: data,
      headers: headers,
      requestOptions: options.copyWith(extra: options.extra),
      statusCode: statusCode,
    );
  }
}
