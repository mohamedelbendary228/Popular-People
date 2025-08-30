import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:popular_people/core/enums/image_size.dart';

/// Model for TMDB Images Configs fetched from the /configuration endpoint

class TMDBImageConfigs extends Equatable {
  final String baseUrl;
  final String secureBaseUrl;
  final List<ImageSize> backdropSizes;
  final List<ImageSize> logoSizes;
  final List<ImageSize> posterSizes;
  final List<ImageSize> profileSizes;
  final List<ImageSize> stillSizes;

  const TMDBImageConfigs({
    required this.baseUrl,
    required this.secureBaseUrl,
    this.backdropSizes = const [],
    this.logoSizes = const [],
    this.posterSizes = const [],
    this.profileSizes = const [],
    this.stillSizes = const [],
  });

  factory TMDBImageConfigs.fromJson(Map<String, dynamic> json) {
    return TMDBImageConfigs(
      baseUrl: json['base_url'] as String,
      secureBaseUrl: json['secure_base_url'] as String,
      backdropSizes: json['backdrop_sizes'] == null
          ? []
          : List<ImageSize>.from(
              (json['backdrop_sizes'] as List<dynamic>).map<ImageSize>(
                (dynamic x) =>
                    ImageSize.values.firstWhereOrNull((value) => value.name == x) ??
                    ImageSize.original,
              ),
            ),
      logoSizes: json['logo_sizes'] == null
          ? []
          : List<ImageSize>.from(
              (json['logo_sizes'] as List<dynamic>).map<ImageSize>(
                (dynamic x) =>
                    ImageSize.values.firstWhereOrNull((value) => value.name == x) ??
                    ImageSize.original,
              ),
            ),
      posterSizes: json['poster_sizes'] == null
          ? []
          : List<ImageSize>.from(
              (json['poster_sizes'] as List<dynamic>).map<ImageSize>(
                (dynamic x) =>
                    ImageSize.values.firstWhereOrNull((value) => value.name == x) ??
                    ImageSize.original,
              ),
            ),
      profileSizes: json['profile_sizes'] == null
          ? []
          : List<ImageSize>.from(
              (json['profile_sizes'] as List<dynamic>).map<ImageSize>(
                (dynamic x) =>
                    ImageSize.values.firstWhereOrNull((value) => value.name == x) ??
                    ImageSize.original,
              ),
            ),
      stillSizes: json['still_sizes'] == null
          ? []
          : List<ImageSize>.from(
              (json['still_sizes'] as List<dynamic>).map<ImageSize>(
                (dynamic x) =>
                    ImageSize.values.firstWhereOrNull((value) => value.name == x) ??
                    ImageSize.original,
              ),
            ),
    );
  }

  /// Builds a valid 'profile' image url given the size and base path
  ///
  /// Example https://image.tmdb.org/t/p/original/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg
  String profileImageUrl(ImageSize size, String path) {
    final imageSize = profileSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  String logoImageUrl(ImageSize size, String path) {
    final imageSize = logoSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  String posterImageUrl(ImageSize size, String path) {
    final imageSize = posterSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  String stillImageUrl(ImageSize size, String path) {
    final imageSize = stillSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  String backdropImage(ImageSize size, String path) {
    final imageSize = backdropSizes.contains(size) ? size.name : ImageSize.original.name;

    return '$secureBaseUrl$imageSize$path';
  }

  @override
  List<Object?> get props => [
        baseUrl,
        secureBaseUrl,
        backdropSizes,
        logoSizes,
        posterSizes,
        profileSizes,
        stillSizes,
      ];
}
