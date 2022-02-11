import '../../lib_exp.dart';

class LoadingDialog {
  static void show(BuildContext context) => context.loaderOverlay.show();

  static void hide(BuildContext context) => context.loaderOverlay.hide();
}
