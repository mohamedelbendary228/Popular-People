import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/services/cache/cache_service.dart';
import 'package:popular_people/core/services/cache/cache_service_impl.dart';

final cacheServiceProvider = Provider<CacheService>(
  (_) => CacheServiceImpl(),
);
