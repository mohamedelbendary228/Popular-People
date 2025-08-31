import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/services/cache/cache_provider.dart';
import 'package:popular_people/core/services/cache/cache_service.dart';
import 'package:popular_people/core/services/cache/cache_service_impl.dart';
import 'package:popular_people/my_app.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      final CacheService initializedCacheService = CacheServiceImpl();
      await initializedCacheService.init();

      runApp(
        ProviderScope(
          overrides: [
            cacheServiceProvider.overrideWithValue(initializedCacheService),
          ],
          child: const MyApp(),
        ),
      );
    },
    // ignore: only_throw_errors
    (e, _) => throw e,
  );
}
