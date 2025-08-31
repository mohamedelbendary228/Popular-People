abstract class CacheService {
  Future<void> init();

  dynamic get(String key);

  Future<void> set(String key, dynamic data);

  Future<void> remove(String key);

  bool has(String key);
}
