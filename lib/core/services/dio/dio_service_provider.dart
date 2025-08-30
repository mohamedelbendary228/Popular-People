import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/services/dio/dio_http_service.dart';
import 'package:popular_people/core/services/dio/http_service.dart';

final dioServiceProvider = Provider<HttpService>((ref) {
  return DioHttpService();
});
