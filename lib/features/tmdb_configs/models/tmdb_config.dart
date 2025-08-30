import 'package:equatable/equatable.dart';
import 'package:popular_people/features/tmdb_configs/models/tmdb_image_configs.dart';

/// Model for TMDB Configs fetched from the /configuration endpoint

class TMDBConfigs extends Equatable {
  final TMDBImageConfigs images;

  const TMDBConfigs({
    required this.images,
  });

  factory TMDBConfigs.fromJson(Map<String, dynamic> json) {
    return TMDBConfigs(
      images: TMDBImageConfigs.fromJson(json['images'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [images];
}
