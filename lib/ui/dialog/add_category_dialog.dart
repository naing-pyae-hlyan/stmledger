import '../../lib_exp.dart';

class AddCategoryDialog {
  static void show(
    BuildContext context, {
    Key? key,
    required ValueChanged<Products> onPresss,
    String btnLabel = 'Save',
    required String title,
    String productName = '',
    String productPrice = '',
  }) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController priceCtrl = TextEditingController();
    final FocusNode nameFn = FocusNode();
    final FocusNode priceFn = FocusNode();
    nameFn.requestFocus();
    nameCtrl.text = productName;
    priceCtrl.text = productPrice;
    BaseDialog.show(
      context,
      onTapActionButton: () {
        if (nameCtrl.text.isEmpty) {
          nameFn.requestFocus();
          return;
        } else if (priceCtrl.text.isEmpty) {
          priceFn.requestFocus();
          return;
        } else {
          onPresss(Products(
            name: nameCtrl.text,
            price: int.parse(priceCtrl.text),
          ));
          context.pop();
        }
      },
      addCloseButton: true,
      onTapActionButtonNeedPop: false,
      actionButtonLabel: btnLabel,
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            _inputForm(
              nameCtrl,
              hintText: 'Name',
              fn: nameFn,
            ),
            _inputForm(
              priceCtrl,
              hintText: '\$ Price',
              keyboardType: TextInputType.number,
              fn: priceFn,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _inputForm(
    TextEditingController controller, {
    required String hintText,
    required FocusNode fn,
    TextInputType keyboardType = TextInputType.text,
  }) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: TextFormField(
          controller: controller,
          focusNode: fn,
          maxLines: 1,
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
}
