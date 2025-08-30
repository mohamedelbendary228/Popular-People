class AppConfigs {
  /// Base API URL of The TMDB API
  static const String baseUrl = 'https://api.themoviedb.org/3';

  /// API Key registered with The TMDB API
  static const String tmdbAPIKey = String.fromEnvironment('TMDB_API_KEY');
}
