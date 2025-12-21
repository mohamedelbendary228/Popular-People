import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/configs/flavor_config.dart';
import 'package:popular_people/core/constants/endpoints_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Provider<Preferences> preferencesProvider = Provider<Preferences>(
  (ref) => Preferences(),
);

class Preferences {
  static late SharedPreferences _prefInstance;

  Preferences();

  Future<void> init() async {
    _prefInstance = await SharedPreferences.getInstance();
  }

  /// FlavorConfig
  Future<dynamic> persistFlavorConfig(FlavorConfig value) async {
    return _prefInstance.setString(flavorConfigKey, jsonEncode(value.toMap()));
  }

  FlavorConfig? get flavorConfig => _prefInstance.getString(flavorConfigKey) == null
      ? null
      : FlavorConfig.fromMap(
          jsonDecode(_prefInstance.getString(flavorConfigKey)!) as Map<String, dynamic>,
        );
}
