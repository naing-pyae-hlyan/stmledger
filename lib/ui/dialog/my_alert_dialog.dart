import '../../lib_exp.dart';

enum AlertType {
  success,
  fail,
  warning,
  info,
}

String _getAssetImageURL(AlertType type) {
  switch (type) {
    case AlertType.success:
      return 'assets/icons/alert_success.png';
    case AlertType.fail:
      return 'assets/icons/alert_fail.png';
    case AlertType.warning:
      return 'assets/icons/alert_warning.png';
    default:
      return 'assets/icons/alert_info.png';
  }
}

Color _getColor(AlertType type) {
  switch (type) {
    case AlertType.success:
      return AppColors.successColor;
    case AlertType.fail:
      return AppColors.errorColor;
    case AlertType.warning:
      return AppColors.warningColor;
    default:
      return AppColors.appBarTextTitleColor;
  }
}

class MyAlertDialog {
  static void show(
    BuildContext context, {
    Key? key,
    required AlertType type,
    required VoidCallback onTapActionButton,
    String actionButtonLabel = 'OK',
    VoidCallback? onTapActionButton2,
    String? actionButtonLabel2,
    required String title,
    required String? description,
    bool? addCloseButton,
  }) {
    BaseDialog.show(
      context,
      onTapActionButton: onTapActionButton,
      actionButtonLabel: actionButtonLabel,
      onTapActionButton2: onTapActionButton2,
      actionButtonLabel2: actionButtonLabel2,
      addCloseButton: addCloseButton,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.greyBackgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              _getAssetImageURL(type),
              width: 80,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: DialogLibTheme.dialogTitleStyle(_getColor(type)),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: context.height - 400,
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Text(
                    description ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.appBarTextTitleColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
