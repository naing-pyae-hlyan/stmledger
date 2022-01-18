import '../../lib_exp.dart';

final GlobalKey<State> _keyLoader = GlobalKey<State>();

class LoadingDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => WillPopScope(
        key: _keyLoader,
        onWillPop: () => Future.value(false),
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    if (_keyLoader.currentContext == null) return;

    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
  }
}
