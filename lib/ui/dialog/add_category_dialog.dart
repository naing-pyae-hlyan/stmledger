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
            names: [nameCtrl.text],
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
            myInputForm(
              nameCtrl,
              hintText: 'Name',
              fn: nameFn,
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            myInputForm(
              priceCtrl,
              hintText: '\$ Price',
              keyboardType: TextInputType.number,
              fn: priceFn,
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ],
        ),
      ),
    );
  }
}
