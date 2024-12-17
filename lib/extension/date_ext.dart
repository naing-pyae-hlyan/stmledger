import 'package:intl/intl.dart';

extension DateExt on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  String get ddMMMyyyyE => DateFormat('dd MMM yyyy E').format(this);
  String get ddMMMyyyyEE => DateFormat('dd MMM yyyy (E)').format(this);
  String get ddMMMyyyy => DateFormat('dd MMM yyyy').format(this);
  String get ddMMyyyy => DateFormat('dd/MM/yyyy').format(this);
  String get ddMMMyyyyHHmm => DateFormat('dd MMM yyyy hh:mm aaa').format(this);
  String get ddMMMhhmmAAA => DateFormat('dd MMM, hh:mm aaa').format(this);

  String get hhMMaaa => DateFormat('hh:mm aaa').format(this);
}
