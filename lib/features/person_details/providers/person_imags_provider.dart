import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/features/person_details/models/person_images.dart';
import 'package:popular_people/features/person_details/repositories/person_details_repository.dart';
import 'package:popular_people/features/tmdb_configs/providers/tmdb_configs_provider.dart';

final personImagesProvider = FutureProvider.family<List<PersonImage>, int>((ref, personId) async {
  final personDetailsRepository = ref.watch(personDetailsRepositoryProvider);
  final tmdbConfigs = await ref.watch(tmdbConfigsProvider.future);

  return personDetailsRepository.getPersonImages(
    personId,
    imageConfigs: tmdbConfigs.images,
  );
});
