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
  }) async {
    final responseData = await dioClient.get(
      EndpointsConstants.popularPeople,
      forceRefresh: forceRefresh,
      queryParameters: <String, dynamic>{
        'page': page,
        'api_key': apiKey,
      },
    );

    return PaginatedResponse.fromJson(
      responseData,
      results: List<Person>.from(
        (responseData['results'] as List<dynamic>).map<Person>(
          (dynamic x) => Person.fromJson(x as Map<String, dynamic>).toPersonWithMedia(imageConfigs),
        ),
      ),
    );
  }
}
