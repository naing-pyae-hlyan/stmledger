import '../lib_exp.dart';

class DialogUtils {
  static void errorDialog(BuildContext context, dynamic resp) {
    String msg = '';
    if (resp is ErrorResponse) {
      msg = resp.message ?? '';
    } else if (resp is String) {
      msg = resp;
    }
    MyAlertDialog.show(
      context,
      type: AlertType.fail,
      onTapActionButton: () {},
      title: 'Fail!',
      description: msg,
    );
  }
}
