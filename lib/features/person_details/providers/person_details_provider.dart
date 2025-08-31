import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/models/person.dart';
import 'package:popular_people/features/person_details/repositories/person_details_repository.dart';
import 'package:popular_people/features/tmdb_configs/providers/tmdb_configs_provider.dart';

final personDetailsProvider = FutureProvider.family<Person, int>((ref, personId) async {
  final personDetailsRepository = ref.watch(personDetailsRepositoryProvider);
  final tmdbConfigs = await ref.watch(tmdbConfigsProvider.future);

  return personDetailsRepository.getPersonDetails(
    personId,
    imageConfigs: tmdbConfigs.images,
  );
});
