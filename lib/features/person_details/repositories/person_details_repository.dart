import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/models/person.dart';
import 'package:popular_people/core/services/dio/dio_client_provider.dart';
import 'package:popular_people/features/person_details/models/person_images.dart';
import 'package:popular_people/features/person_details/repositories/person_details_repository_impl.dart';
import 'package:popular_people/features/tmdb_configs/models/tmdb_image_configs.dart';

final personDetailsRepositoryProvider = Provider<PersonDetailsRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PersonDetailsRepositoryImpl(dioClient: dioClient);
});

abstract class PersonDetailsRepository {
  String get apiKey;

  Future<Person> getPersonDetails(
    int personId, {
    required TMDBImageConfigs imageConfigs,
  });

  Future<List<PersonImage>> getPersonImages(
    int personId, {
    required TMDBImageConfigs imageConfigs,
  });

  Future<void> saveNetworkImageToGallery(String imageUrl);
}
