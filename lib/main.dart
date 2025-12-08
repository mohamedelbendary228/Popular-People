import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/services/cache/cache_provider.dart';
import 'package:popular_people/core/services/cache/cache_service.dart';
import 'package:popular_people/core/services/cache/cache_service_impl.dart';
import 'package:popular_people/firebase_options.dart';
import 'package:popular_people/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
}
