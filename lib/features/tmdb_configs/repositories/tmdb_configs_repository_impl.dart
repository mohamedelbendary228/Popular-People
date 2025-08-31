import 'package:popular_people/core/configs/app_configs.dart';
import 'package:popular_people/core/constants/endpoints_constants.dart';
import 'package:popular_people/core/services/dio/dio_client.dart';
import 'package:popular_people/features/tmdb_configs/models/tmdb_config.dart';
import 'package:popular_people/features/tmdb_configs/repositories/tmdb_configs_repository.dart';

class TMDBConfigsRepositoryImpl implements TMDBConfigsRepository {
  final DioClient dioClient;
  TMDBConfigsRepositoryImpl({required this.dioClient});

  @override
  String get apiKey => AppConfigs.tmdbAPIKey;

  @override
  Future<TMDBConfigs> getConfigs({bool forceRefresh = false}) async {
    final response = await dioClient.get(
      EndpointsConstants.configuration,
      forceRefresh: forceRefresh,
      queryParameters: {
        'api_key': apiKey,
      },
    );
    return TMDBConfigs.fromJson(response);
  }
}
