import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/services/dio/dio_client_provider.dart';
import 'package:popular_people/features/tmdb_configs/models/tmdb_config.dart';
import 'package:popular_people/features/tmdb_configs/repositories/tmdb_configs_repository_impl.dart';

final tmdbConfigsRepositoryProvider = Provider<TMDBConfigsRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TMDBConfigsRepositoryImpl(dioClient: dioClient);
});

abstract class TMDBConfigsRepository {
  String get apiKey;
  Future<TMDBConfigs> getConfigs();
}
