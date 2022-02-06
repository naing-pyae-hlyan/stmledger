import '../lib_exp.dart';

class CommonUtils {
  static Future<void> clearAllData({bool keepLoginCredentials = false}) async {
    await VoucherTable.deleteAll();
    await WarehouseTable.deleteAll();
  }

  static Future<String> get appVersion async {
    String v = '';
    final packageInfo = await PackageInfoUtils.packageInfo;
    v += packageInfo.version;

    return v;
  }

  static Widget versionLabel({Color? color}) => FutureBuilder<String>(
        future: CommonUtils.appVersion,
        builder: (context, snapshot) {
          return Text(
            (snapshot.hasData && snapshot.data != null)
                ? 'Version ${snapshot.data!}'
                : 'Version 0.0.0',
          );
        },
      );
}

bool searchContainName(String? name, String? query) {
  if (name == null || query == null) return true;

  return name.toUpperCase().replaceAll(' ', '').contains(query.toUpperCase());
}
