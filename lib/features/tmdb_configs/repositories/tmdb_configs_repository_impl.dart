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
  Future<TMDBConfigs> getConfigs({
    bool forceRefresh = false,
    bool isIsolate = false,
  }) async {
    return await dioClient.get<TMDBConfigs>(
      EndpointsConstants.configuration,
      forceRefresh: forceRefresh,
      isIsolate: isIsolate,
      queryParameters: <String, dynamic>{
        'api_key': apiKey,
      },
      converter: (dynamic data) {
        final map = Map<String, dynamic>.from(data as Map<dynamic, dynamic>);
        return TMDBConfigs.fromJson(map);
      },
    );
  }
}
