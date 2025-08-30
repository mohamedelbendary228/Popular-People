import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:popular_people/core/enums/gender.dart';
import 'package:popular_people/core/enums/image_size.dart';
import 'package:popular_people/core/models/tmdb_image_configs.dart';
import 'package:popular_people/features/popular_people/models/known_for.dart';

class Person extends Equatable {
  final bool adult;
  final Gender gender;
  final int? id;
  final List<KnownFor> knownFor;
  final String? knownForDepartment;
  final String name;
  final double popularity;
  final String? profilePath;
  final String? avatar;
  final String? cover;
  final String? biography;
  final DateTime? birthday;
  final DateTime? deathDate;
  final String? homepage;
  final String? imdbId;
  final String? placeOfBirth;

  const Person({
    this.adult = false,
    this.gender = Gender.unknown,
    this.id,
    this.knownFor = const [],
    this.knownForDepartment,
    this.name = '',
    this.popularity = 0,
    this.profilePath,
    this.avatar,
    this.cover,
    this.biography,
    this.birthday,
    this.deathDate,
    this.homepage,
    this.imdbId,
    this.placeOfBirth,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    DateTime? birthday;

    try {
      birthday = json['birthday'] == null || (json['birthday'] as String).isEmpty
          ? null
          : DateTime.parse(json['birthday'] as String);
    } catch (e) {
      log('Error parsing birthday date! ${json['birthday']}');
    }
    DateTime? deathDate;

    try {
      deathDate = json['deathday'] == null || (json['deathday'] as String).isEmpty
          ? null
          : DateTime.parse(json['deathday'] as String);
    } catch (e) {
      log('Error parsing deathDate date! ${json['deathday']}');
    }
    return Person(
      adult: (json['adult'] as bool?) ?? false,
      gender: json['gender'] == null ? Gender.unknown : Gender.fromInt(json['gender'] as int),
      id: json['id'] as int?,
      knownFor: json['known_for'] == null
          ? []
          : List<KnownFor>.from(
              (json['known_for'] as List<dynamic>).map<KnownFor>(
                (dynamic x) => KnownFor.fromJson(x as Map<String, dynamic>),
              ),
            ),
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      biography: json['biography'] as String?,
      birthday: birthday,
      deathDate: deathDate,
      homepage: json['homepage'] as String?,
      imdbId: json['imdb_id'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
    );
  }

  static ImageSize avatarSize = ImageSize.h632;

  static ImageSize coverSize = ImageSize.original;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'adult': adult,
      'gender': gender.toInt,
      'id': id,
      'known_for': List<dynamic>.from(
        knownFor.map<Map<String, dynamic>>((x) => x.toJson()),
      ),
      'known_for_department': knownForDepartment,
      'name': name,
      'popularity': popularity,
      'profile_path': profilePath,
      'biography': biography,
      'birthday': birthday == null ? null : DateFormat('yyyy-MM-dd').format(birthday!),
      'deathday': deathDate == null ? null : DateFormat('yyyy-MM-dd').format(deathDate!),
      'homepage': homepage,
      'imdb_id': imdbId,
      'place_of_birth': placeOfBirth,
    };
  }

  Person populateImages(TMDBImageConfigs imageConfigs) {
    return Person(
      adult: adult,
      gender: gender,
      id: id,
      knownFor: knownFor.map((media) => media.populateImages(imageConfigs)).toList(),
      knownForDepartment: knownForDepartment,
      name: name,
      popularity: popularity,
      profilePath: profilePath,
      avatar: profilePath == null ? null : imageConfigs.profileImageUrl(avatarSize, profilePath!),
      cover: profilePath == null ? null : imageConfigs.profileImageUrl(coverSize, profilePath!),
      biography: biography,
      birthday: birthday,
      deathDate: deathDate,
      homepage: homepage,
      imdbId: imdbId,
      placeOfBirth: placeOfBirth,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        gender,
        id,
        knownFor,
        knownForDepartment,
        name,
        popularity,
        profilePath,
        avatar,
        cover,
        biography,
        birthday,
        deathDate,
        homepage,
        imdbId,
        placeOfBirth,
      ];
}
