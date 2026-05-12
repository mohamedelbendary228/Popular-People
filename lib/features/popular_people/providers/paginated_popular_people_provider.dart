import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/models/paginated_response.dart';
import 'package:popular_people/core/models/person.dart';
import 'package:popular_people/features/popular_people/repositories/popular_people_repository.dart';
import 'package:popular_people/features/popular_people/view/widgets/popular_people_list.dart';
import 'package:popular_people/features/tmdb_configs/providers/tmdb_configs_provider.dart';

final paginatedPopularPeopleProvider =
    FutureProvider.family<PaginatedResponse<Person>, int>((ref, pageIndex) async {
  final peopleRepository = ref.watch(peopleRepositoryProvider);
  final tmdbConfigs = await ref.watch(tmdbConfigsProvider.future);

  return peopleRepository.getPopularPeople(
    page: pageIndex + 1,
    imageConfigs: tmdbConfigs.images,
    forceRefresh: ref.watch(isForceRefreshing),
  );
});
