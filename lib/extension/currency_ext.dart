import 'package:intl/intl.dart';

extension CurrencyFormat on String {
  String get currency => this.isEmpty
      ? ''
      : NumberFormat.decimalPattern('en').format(int.parse(this));
}
