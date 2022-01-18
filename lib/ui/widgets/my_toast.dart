import '../../lib_exp.dart';

void showToast(
  FToast? fToast, {
  required String msg,
  AlertType alertType = AlertType.success,
}) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(_getIcon(alertType)),
        const SizedBox(width: 12.0),
        Text(msg),
      ],
    ),
  );
  fToast?.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2));
}

IconData _getIcon(AlertType type) {
  switch (type) {
    case AlertType.success:
      return Icons.check;
    case AlertType.fail:
      return Icons.close;
    case AlertType.warning:
      return Icons.warning;
    default:
      return Icons.info;
  }
}
