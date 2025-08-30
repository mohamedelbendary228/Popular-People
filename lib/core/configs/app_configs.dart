import 'package:popular_people/core/constants/endpoints_constants.dart';

class AppConfigs {
  /// Base API URL of The TMDB API
  static const String baseUrl = EndpointsConstants.baseUrl;

  /// API Key registered with The TMDB API
  static const String tmdbAPIKey = String.fromEnvironment('TMDB_API_KEY');
}
