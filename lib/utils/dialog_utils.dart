import '../lib_exp.dart';

class DialogUtils {
  static void errorDialog(
    BuildContext context,
    dynamic resp, {
    String title = 'Fail!',
    AlertType alertType = AlertType.fail,
  }) {
    String msg = '';
    if (resp is ErrorResponse) {
      msg = resp.message ?? '';
    } else if (resp is String) {
      msg = resp;
    }
    MyAlertDialog.show(
      context,
      type: alertType,
      onTapActionButton: () {},
      title: title,
      description: msg,
    );
  }
}
