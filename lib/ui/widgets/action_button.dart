import '../../lib_exp.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color? color;
  final Color? labelColor;
  final double? width;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final String label;
  final FontWeight? labelWeight;
  final double fontSize;

  const ActionButton({
    Key? key,
    required this.onTap,
    this.color,
    this.width = double.infinity,
    this.fontSize = 13.0,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
    required this.label,
    this.labelWeight,
    this.labelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 8,
        primary: color ?? AppColors.primaryColor,
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(50),
        ),
      ),
      child: _body,
    );
  }

  Widget get _body => Container(
        width: width,
        padding: padding,
        alignment: Alignment.center,
        child: _label,
      );

  Widget get _label => Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: labelWeight ?? FontWeight.bold,
          color: labelColor ?? Colors.white,
        ),
      );
}
