class MyDateUtils {
  static int get timestampNow => DateTime.now().millisecondsSinceEpoch;

  static DateTime convertTimestempToDate(int? timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp ?? timestampNow);
}
