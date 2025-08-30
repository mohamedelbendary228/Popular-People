import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/theme/app_theme.dart';
import 'package:popular_people/core/widgets/error_widget.dart';
import 'package:popular_people/core/widgets/loading_widget.dart';
import 'package:popular_people/features/popular_people/view/popular_people_page.dart';
import 'package:popular_people/features/tmdb_configs/models/tmdb_config.dart';
import 'package:popular_people/features/tmdb_configs/providers/tmdb_configs_provider.dart';
import 'package:popular_people/routes/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configsAsync = ref.watch(tmdbConfigsProvider);
    return MaterialApp(
      title: 'Popular People',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      onGenerateRoute: AppRouter.router,
      home: configsAsync.when(
        data: (TMDBConfigs tmdbConfigs) {
          return const PopularPeoplePage();
        },
        error: (Object error, StackTrace? stackTrace) {
          log('Error fetching configurations');
          log(error.toString());
          log(stackTrace.toString());
          return const Scaffold(body: ErrorView());
        },
        loading: () => const Scaffold(body: LoadingWidget()),
      ),
    );
  }
}
