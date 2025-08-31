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
  Future<Person> getPersonDetails(int personId,
      {bool forceRefresh = false, required TMDBImageConfigs imageConfigs, f}) async {
    final response = await dioClient.get(
      "/person/$personId",
      forceRefresh: forceRefresh,
      queryParameters: <String, dynamic>{
        'api_key': apiKey,
      },
    );
    return Person.fromJson(response).toPersonWithMedia(imageConfigs);
  }

  @override
  Future<List<PersonImage>> getPersonImages(
    int personId, {
    bool forceRefresh = false,
    required TMDBImageConfigs imageConfigs,
  }) async {
    final responseData = await dioClient.get(
      '/person/$personId/images',
      forceRefresh: forceRefresh,
      queryParameters: <String, dynamic>{
        'api_key': apiKey,
      },
    );

    return List<PersonImage>.from(
      (responseData['profiles'] as List<dynamic>).map<PersonImage>(
        (dynamic x) => PersonImage.fromJson(x as Map<String, dynamic>).toPersonImages(imageConfigs),
      ),
    );
  }

  @override
  Future<void> saveNetworkImageToGallery(String imageUrl) async {
    await GallerySaver.saveImage(imageUrl);
  }
}
