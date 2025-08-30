import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/services/dio/dio_client_impl.dart';
import 'package:popular_people/core/services/dio/dio_client.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClientImpl();
});
