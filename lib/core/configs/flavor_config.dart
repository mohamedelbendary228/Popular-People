import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/extensions/hex_color_extension.dart';
import 'package:popular_people/core/helpers/package_info_helper.dart';
import 'package:popular_people/core/services/cache/preferences.dart';

/// Detects when the app is built with a non-production release, to enable changing flavors.
bool? hasBeenNonProduction;

class Flavor {
  static const String dev = 'dev';
  static const String production = 'production';
}

class FlavorValues {
  final String apiBaseUrl;
  final String? releaseVersion;
  final String? mobileAppVersion;

  const FlavorValues({
    required this.apiBaseUrl,
    this.releaseVersion,
    this.mobileAppVersion,
  });

  FlavorValues copyWith({
    String? apiBaseUrl,
    String? mobileAppVersion,
    String? releaseVersion,
    String? configNumber,
  }) {
    return FlavorValues(
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      mobileAppVersion: mobileAppVersion ?? this.mobileAppVersion,
      releaseVersion: releaseVersion ?? this.releaseVersion,
    );
  }

  factory FlavorValues.fromMap(Map<String, dynamic> json) => FlavorValues(
        apiBaseUrl: json['apiBaseUrl'].toString(),

        ///To get version from previouse
        mobileAppVersion: (json['version'] ?? json['mobileAppVersion'])?.toString(),
        releaseVersion: json['releaseVersion'].toString(),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "apiBaseUrl": apiBaseUrl,
        "mobileAppVersion": mobileAppVersion,
        "releaseVersion": releaseVersion,
      };
}

class FlavorConfig {
  final String name;
  final FlavorValues values;
  final Color? color;

  const FlavorConfig({
    required this.name,
    required this.values,
    this.color,
  });

  static late FlavorConfig _instance;

  static FlavorConfig get instance {
    return _instance;
  }

  String get configNumber => const String.fromEnvironment("CONFIG_NUMBER");

  static void set(FlavorConfig flavorConfig, ProviderContainer container) {
    _instance = flavorConfig.copyWith(
      values: flavorConfig.values.copyWith(
        mobileAppVersion: container.read(packageInfoHelperProvider).mobileAppVersion,
        releaseVersion: '1.3.4.2',
        configNumber: const String.fromEnvironment("CONFIG_NUMBER"),
      ),
    );
    final Preferences preferences = container.read(preferencesProvider);
    hasBeenNonProduction ??= !isProduction() || preferences.flavorConfig != null;
    preferences.persistFlavorConfig(_instance);
  }

  FlavorConfig copyWith({
    String? name,
    Color? color,
    FlavorValues? values,
  }) {
    return FlavorConfig(
      name: name ?? this.name,
      color: color ?? this.color,
      values: values ?? this.values,
    );
  }

  factory FlavorConfig.fromMap(Map<String, dynamic> json) {
    final String name = json["name"]?.toString() ?? '';
    return FlavorConfig(
      name: name,
      values: FlavorValues.fromMap(json["values"] as Map<String, dynamic>),
      color: json["color"] == null ? null : HexColor.fromHex(json["color"]?.toString()),
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "name": name,
        "values": values.toMap(),
        "color": color?.toHex(),
      };

  //*[FlavorConfig.fromEnv] used to get keys from env
  //*version number should be specified in --dart-define-from-file
  //*ex. flutter run --dart-define-from-file=dev_config_v1.json

  factory FlavorConfig.fromEnv(String version) {
    debugPrint("Config version $version");
    const String flavor = String.fromEnvironment("FLAVOR");
    const String apiBaseUrl = String.fromEnvironment("BASE_URL");

    switch (flavor) {
      case "dev":
        return FlavorConfig.dev(
          apiBaseUrl: apiBaseUrl,
        );
      case "production":
        return FlavorConfig.production(
          apiBaseUrl: apiBaseUrl,
        );
      default:
        return FlavorConfig.production(
          apiBaseUrl: apiBaseUrl,
        );
    }
  }

  factory FlavorConfig.dev({
    required String apiBaseUrl,
    String? paymentBaseUrl,
  }) {
    return FlavorConfig(
      name: Flavor.dev,
      values: FlavorValues(
        apiBaseUrl: apiBaseUrl,
      ),
      color: const Color(0xFFDD2222),
    );
  }

  factory FlavorConfig.production({
    required String apiBaseUrl,
  }) {
    return FlavorConfig(
      name: Flavor.production,
      values: FlavorValues(
        apiBaseUrl: apiBaseUrl,
      ),
      color: Colors.green,
    );
  }

  /// The main flavor that doesn't appear for the public release.
  static bool isProduction() => _instance.name == Flavor.production;
  static bool isDevelopment() => _instance.name == Flavor.dev;
}
