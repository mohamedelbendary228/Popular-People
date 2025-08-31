import 'package:popular_people/core/models/person.dart';
import 'package:popular_people/features/tmdb_configs/models/tmdb_image_configs.dart';

abstract class PersonDetailsRepository {
  String get apiKey;

  Future<Person> getPersonDetails(
    int personId, {
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  });
}
