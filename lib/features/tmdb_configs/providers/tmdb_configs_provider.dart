import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/features/tmdb_configs/models/tmdb_config.dart';
import 'package:popular_people/features/tmdb_configs/repositories/tmdb_configs_repository.dart';

final tmdbConfigsProvider = FutureProvider<TMDBConfigs>((ref) async {
  final tmdbConfigsRepository = ref.watch(tmdbConfigsRepositoryProvider);

  return tmdbConfigsRepository.getConfigs();
});
