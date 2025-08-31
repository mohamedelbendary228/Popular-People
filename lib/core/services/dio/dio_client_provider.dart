import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/services/cache/cache_provider.dart';
import 'package:popular_people/core/services/dio/dio_client_impl.dart';
import 'package:popular_people/core/services/dio/dio_client.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  final cacheService = ref.watch(cacheServiceProvider);
  return DioClientImpl(cacheService: cacheService);
});
