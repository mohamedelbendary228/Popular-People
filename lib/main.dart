import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/configs/flavor_config.dart';
import 'package:popular_people/core/helpers/package_info_helper.dart';
import 'package:popular_people/core/services/cache/cache_provider.dart';
import 'package:popular_people/core/services/cache/cache_service.dart';
import 'package:popular_people/core/services/cache/cache_service_impl.dart';
import 'package:popular_people/core/services/cache/preferences.dart';
import 'package:popular_people/firebase_options.dart';
import 'package:popular_people/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ProviderContainer providerContainer = ProviderContainer();

  final CacheService initializedCacheService = CacheServiceImpl();
  final Preferences preferences = providerContainer.read(preferencesProvider);

  await providerContainer.read(packageInfoHelperProvider).getPackageVersion();
  await initializedCacheService.init();
  await preferences.init();

  FlavorConfig.set(
    preferences.flavorConfig ?? FlavorConfig.fromEnv("V1"),
    providerContainer,
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      overrides: [
        cacheServiceProvider.overrideWithValue(initializedCacheService),
      ],
      child: const MyApp(),
    ),
  );
}
