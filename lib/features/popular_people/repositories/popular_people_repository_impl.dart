import 'package:popular_people/core/configs/app_configs.dart';
import 'package:popular_people/core/constants/endpoints_constants.dart';
import 'package:popular_people/core/models/paginated_response.dart';
import 'package:popular_people/features/tmdb_configs/models/tmdb_image_configs.dart';
import 'package:popular_people/core/services/dio/dio_client.dart';
import 'package:popular_people/core/models/person.dart';
import 'package:popular_people/features/popular_people/repositories/popular_people_repository.dart';

class PopularPeopleRepositoryImpl implements PopularPeopleRepository {
  final DioClient dioClient;

  PopularPeopleRepositoryImpl(this.dioClient);

  @override
  String get apiKey => AppConfigs.tmdbAPIKey;

  @override
  Future<PaginatedResponse<Person>> getPopularPeople({
    int page = 1,
    required TMDBImageConfigs imageConfigs,
    bool forceRefresh = false,
    bool isIsolate = false,
  }) async {
    return await dioClient.get<PaginatedResponse<Person>>(
      EndpointsConstants.popularPeople,
      forceRefresh: forceRefresh,
      isIsolate: isIsolate,
      queryParameters: <String, dynamic>{
        'page': page,
        'api_key': apiKey,
      },
      converter: (dynamic data) {
        final map = Map<String, dynamic>.from(data as Map<dynamic, dynamic>);
        final results = (map['results'] as List<dynamic>)
            .map(
              (dynamic x) =>
                  Person.fromJson(x as Map<String, dynamic>).toPersonWithMedia(imageConfigs),
            )
            .toList();

        return PaginatedResponse.fromJson(map, results: results);
      },
    );
  }
}
