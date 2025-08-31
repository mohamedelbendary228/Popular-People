import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/models/paginated_response.dart';
import 'package:popular_people/core/models/person.dart';
import 'package:popular_people/features/popular_people/providers/paginated_popular_people_provider.dart';

final popularPeopleCountProvider = Provider<AsyncValue<int>>((ref) {
  return ref.watch(paginatedPopularPeopleProvider(0)).whenData(
        (PaginatedResponse<Person> pageData) => pageData.totalResults,
      );
});
