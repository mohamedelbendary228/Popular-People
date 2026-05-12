import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final Provider<PackageInfoHelper> packageInfoHelperProvider = Provider<PackageInfoHelper>(
  (ref) => PackageInfoHelper(),
);

class PackageInfoHelper {
  late String _mobileAppVersion;

  String get mobileAppVersion => _mobileAppVersion;

  late String _version;

  String get version => _version;

  Future<String> getPackageVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    return _mobileAppVersion = '${packageInfo.version}.${packageInfo.buildNumber}';
  }
}
