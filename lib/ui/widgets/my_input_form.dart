import '../../lib_exp.dart';

Widget myInputForm(
  TextEditingController controller, {
  required String hintText,
  FocusNode? fn,
  EdgeInsetsGeometry? margin,
  TextInputType keyboardType = TextInputType.text,
  int maxLine = 1,
}) =>
    Container(
      margin: margin,
      child: TextFormField(
        controller: controller,
        focusNode: fn,
        maxLines: maxLine,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 12,
            color: AppColors.primaryColor.withOpacity(0.8),
          ),
        ),
      ),
    );
