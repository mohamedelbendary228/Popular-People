import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/models/paginated_response.dart';
import 'package:popular_people/core/models/tmdb_image_configs.dart';
import 'package:popular_people/core/services/dio/dio_client_provider.dart';
import 'package:popular_people/features/popular_people/models/person.dart';
import 'package:popular_people/features/popular_people/repositories/popular_people_repository_impl.dart';

final peopleRepositoryProvider = Provider<PopularPeopleRepository>(
  (ref) {
    final dioClient = ref.watch(dioClientProvider);
    return PopularPeopleRepositoryImpl(dioClient);
  },
);

abstract class PopularPeopleRepository {
  String get apiKey;

  Future<PaginatedResponse<Person>> getPopularPeople({
    int page = 1,
    required TMDBImageConfigs imageConfigs,
  });
}
