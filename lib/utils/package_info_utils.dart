import '../lib_exp.dart';

class PackageInfoUtils {
  static PackageInfo? _packageInfo;

  static Future<PackageInfo> get packageInfo async {
    if (_packageInfo != null) {
      return _packageInfo!;
    }

    try {
      _packageInfo = await PackageInfo.fromPlatform();
    } catch (e) {
      _packageInfo = PackageInfo(
        version: '',
        buildNumber: '',
        packageName: '',
        appName: '',
      );
    }

    return _packageInfo!;
  }
}
