import 'package:popular_people/core/constants/endpoints_constants.dart';

class AppConfigs {
  /// Base API URL of The TMDB API
  static const String baseUrl = EndpointsConstants.baseUrl;

  /// API Key registered with The TMDB API
  static const String tmdbAPIKey = String.fromEnvironment('TMDB_API_KEY');

  /// The max allowed age duration for the http cache
  static const Duration maxCacheAge = Duration(minutes: 30);

  /// Key used in dio options to indicate whether
  /// cache should be force refreshed
  static const String dioCacheForceRefreshKey = 'dio_cache_force_refresh_key';
}
