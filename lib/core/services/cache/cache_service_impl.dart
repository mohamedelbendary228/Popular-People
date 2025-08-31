import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:popular_people/core/services/cache/cache_service.dart';

class CacheServiceImpl implements CacheService {
  late Box<dynamic> hiveBox;

  Future<void> openBox([String boxName = 'POPULAR_PEOPLE']) async {
    Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
    hiveBox = Hive.box(name: boxName);
  }

  @override
  Future<void> init() async {
    await openBox();
  }

  @override
  Future<void> remove(String key) async {
    hiveBox.delete(key);
  }

  @override
  dynamic get(String key) {
    return hiveBox.get(key);
  }

  @override
  bool has(String key) {
    return hiveBox.containsKey(key);
  }

  @override
  Future<void> set(String key, dynamic data) async {
    hiveBox.put(key, data);
  }
}
