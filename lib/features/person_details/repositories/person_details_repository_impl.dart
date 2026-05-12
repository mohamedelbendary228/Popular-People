import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:popular_people/core/configs/app_configs.dart';
import 'package:popular_people/core/models/person.dart';
import 'package:popular_people/core/services/dio/dio_client.dart';
import 'package:popular_people/features/person_details/models/person_images.dart';
import 'package:popular_people/features/person_details/repositories/person_details_repository.dart';
import 'package:popular_people/features/tmdb_configs/models/tmdb_image_configs.dart';

class PersonDetailsRepositoryImpl implements PersonDetailsRepository {
  final DioClient dioClient;

  PersonDetailsRepositoryImpl({required this.dioClient});
  @override
  String get apiKey => AppConfigs.tmdbAPIKey;

  @override
  Future<Person> getPersonDetails(
    int personId, {
    required TMDBImageConfigs imageConfigs,
    bool forceRefresh = false,
    bool isIsolate = false,
  }) {
    return dioClient.get<Person>(
      '/person/$personId',
      forceRefresh: forceRefresh,
      isIsolate: isIsolate,
      queryParameters: <String, dynamic>{
        'api_key': apiKey,
      },
      converter: (dynamic data) {
        final map = Map<String, dynamic>.from(data as Map<dynamic, dynamic>);
        return Person.fromJson(map).toPersonWithMedia(imageConfigs);
      },
    );
  }

  @override
  Future<List<PersonImage>> getPersonImages(
    int personId, {
    required TMDBImageConfigs imageConfigs,
    bool forceRefresh = false,
    bool isIsolate = false,
  }) {
    return dioClient.get<List<PersonImage>>(
      '/person/$personId/images',
      forceRefresh: forceRefresh,
      isIsolate: isIsolate,
      queryParameters: <String, dynamic>{
        'api_key': apiKey,
      },
      converter: (dynamic data) {
        final map = Map<String, dynamic>.from(data as Map<dynamic, dynamic>);
        final profiles = map['profiles'] as List<dynamic>;

        return profiles
            .map(
              (dynamic x) =>
                  PersonImage.fromJson(x as Map<String, dynamic>).toPersonImages(imageConfigs),
            )
            .toList();
      },
    );
  }

  @override
  Future<void> saveNetworkImageToGallery(String imageUrl) {
    return GallerySaver.saveImage(imageUrl);
  }
}
