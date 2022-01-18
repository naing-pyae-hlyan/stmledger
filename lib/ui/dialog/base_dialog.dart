import '../../lib_exp.dart';

class BaseDialog extends StatefulWidget {
  final Widget child;
  // action button is hide if onTapActionButton is null.
  final VoidCallback? onTapCloseButton;
  final VoidCallback? onTapActionButton;
  final String actionButtonLabel;
  final VoidCallback? onTapActionButton2;
  final String? actionButtonLabel2;
  final bool? addCloseButton;
  final bool onTapActionButtonNeedPop;

  const BaseDialog({
    Key? key,
    required this.child,
    this.onTapCloseButton,
    this.onTapActionButton,
    required this.actionButtonLabel,
    this.onTapActionButton2,
    this.actionButtonLabel2,
    this.addCloseButton,
    this.onTapActionButtonNeedPop = true,
  }) : super(key: key);

  @override
  _BaseDialogState createState() => _BaseDialogState();

  static void show(
    BuildContext context, {
    Key? key,
    required Widget child,
    VoidCallback? onTapCloseButton,
    VoidCallback? onTapActionButton,
    String actionButtonLabel = 'OK',
    VoidCallback? onTapActionButton2,
    String? actionButtonLabel2,
    bool? addCloseButton = true,
    bool onTapActionButtonNeedPop = true,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: BaseDialog(
          key: key,
          child: child,
          onTapCloseButton: onTapCloseButton,
          onTapActionButton: onTapActionButton,
          actionButtonLabel: actionButtonLabel,
          onTapActionButton2: onTapActionButton2,
          actionButtonLabel2: actionButtonLabel2,
          addCloseButton: addCloseButton,
          onTapActionButtonNeedPop: onTapActionButtonNeedPop,
        ),
      ),
    );
  }
}

class _BaseDialogState extends State<BaseDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
      insetPadding: EdgeInsets.symmetric(
        horizontal: context.fivePercentOfWidth,
      ),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          width: context.width - (context.fivePercentOfWidth * 2),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.child,
                  _buttons(context),
                ],
              ),
            ),
          ),
        ),
        widget.addCloseButton == true
            ? _closeButton(context)
            : const SizedBox(),
      ],
    );
  }

  Widget _buttons(BuildContext context) {
    if (widget.onTapActionButton2 != null &&
        widget.actionButtonLabel2 != null &&
        widget.onTapActionButton != null &&
        widget.onTapActionButton != null) {
      return _okCancelButton(
        label1: widget.actionButtonLabel,
        label2: widget.actionButtonLabel2 ?? '',
        callback1: widget.onTapActionButton!,
        callback2: widget.onTapActionButton2!,
      );
    } else if (widget.onTapActionButton != null &&
        widget.onTapActionButton != null) {
      return _actionButton(
        widget.actionButtonLabel,
        () {
          if (widget.onTapActionButtonNeedPop) context.pop();

          widget.onTapActionButton!();
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _closeButton(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.pop();

              if (widget.onTapCloseButton != null) {
                widget.onTapCloseButton!();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: AppColors.primaryColor,
                ),
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Icon(
                Icons.close_rounded,
                size: 30,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _okCancelButton(
          {required String label1,
          required String label2,
          required VoidCallback callback1,
          required VoidCallback callback2}) =>
      Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        height: 48,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ActionButton(
                onTap: callback1,
                label: label1,
                width: 120,
              ),
              const SizedBox(width: 16),
              ActionButton(
                onTap: callback2,
                label: label2,
                width: 120,
              ),
            ],
          ),
        ),
      );

  Widget _actionButton(String label, VoidCallback callback) => Container(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: context.tenPercentOfWidth + 8,
        ),
        child: ActionButton(
          onTap: callback,
          label: label,
        ),
      );
}
