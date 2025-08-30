import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:popular_people/core/enums/image_size.dart';
import 'package:popular_people/core/enums/media_type.dart';
import 'package:popular_people/features/tmdb_configs/models/tmdb_image_configs.dart';

class KnownFor extends Equatable {
  final int id;
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final MediaType mediaType;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;

  /// Media's posterPath
  ///
  /// used with [TMDBImageConfigs] to generate
  /// valid urls for [poster] and [posterThumb]
  final String? posterPath;

  /// Generated image Url from [TMDBImageConfigs] and [posterPath]
  /// with a [posterThumbSize]
  final String? posterThumb;

  /// Generated image Url from [TMDBImageConfigs] and [posterPath]
  /// with a [posterSize]
  final String? poster;
  final DateTime? releaseDate;
  final String? title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  const KnownFor({
    required this.id,
    this.adult = false,
    this.backdropPath,
    this.genreIds = const [],
    this.mediaType = MediaType.unknown,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.posterThumb,
    this.poster,
    this.releaseDate,
    this.title,
    this.video = false,
    this.voteAverage = 0,
    this.voteCount = 0,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) {
    var mediaType = MediaType.unknown;
    try {
      mediaType = MediaType.values.byName(json['media_type'] as String);
    } catch (_) {
      log('Unknown media type!');
    }

    DateTime? releaseDate;
    try {
      releaseDate = json['release_date'] == null || (json['release_date'] as String).isEmpty
          ? null
          : DateTime.parse(json['release_date'] as String);
    } catch (e) {
      log('Error parsing releaseDate date! ${json['release_date']}');
    }

    return KnownFor(
      id: json['id'] as int,
      adult: (json['adult'] as bool?) ?? false,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: List<int>.from(
        (json['genre_ids'] as List<dynamic>).map<int>((dynamic x) => x as int),
      ),
      mediaType: mediaType,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: releaseDate,
      title: json['title'] as String?,
      video: (json['video'] as bool?) ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: (json['vote_count'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'media_type': mediaType.name,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate == null ? null : DateFormat('yyyy-MM-dd').format(releaseDate!),
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  static ImageSize posterThumbSize = ImageSize.w500;

  static ImageSize posterSize = ImageSize.original;

  KnownFor populateImages(TMDBImageConfigs imageConfigs) {
    return KnownFor(
      id: id,
      adult: adult,
      backdropPath: backdropPath,
      genreIds: genreIds,
      mediaType: mediaType,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      posterThumb:
          posterPath == null ? null : imageConfigs.profileImageUrl(posterThumbSize, posterPath!),
      poster: posterPath == null ? null : imageConfigs.profileImageUrl(posterSize, posterPath!),
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        adult,
        backdropPath,
        genreIds,
        mediaType,
        originalLanguage,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
