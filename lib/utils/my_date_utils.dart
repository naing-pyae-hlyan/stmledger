class MyDateUtils {
  static int get timestampNow => DateTime.now().millisecondsSinceEpoch;

  static String get iso8601Date => DateTime.now().toIso8601String();

  static DateTime convertIso8601StringToDateTime(String? str) =>
      DateTime.parse(str!);

  static DateTime convertTimestempToDate(int? timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp!);
}
