import '../../lib_exp.dart';

class WarehouseAddInstockDialog {
  static void show(
    BuildContext context, {
    required WarehouseModel warehouseModel,
    required ValueChanged<WarehouseModel> onSave,
    Key? key,
  }) {
    final TextEditingController _nameCtrl = TextEditingController();
    final TextEditingController _inCtrl = TextEditingController();
    final FocusNode _fn = FocusNode();

    _nameCtrl.text = warehouseModel.productName!;
    _fn.requestFocus();

    BaseDialog.show(
      context,
      addCloseButton: true,
      onTapActionButtonNeedPop: false,
      onTapActionButton: () {
        if (_inCtrl.text.isEmpty) {
          _fn.requestFocus();
          return;
        } else if (int.parse(_inCtrl.text) == 0) {
          _fn.requestFocus();
          return;
        } else {
          context.pop();
          onSave(WarehouseModel(
            id: warehouseModel.id,
            productId: warehouseModel.productId,
            iso8601Date: warehouseModel.iso8601Date,
            productName: warehouseModel.productName,
            inStock: int.parse(_inCtrl.text),
            outStock: warehouseModel.outStock,
          ));
        }
      },
      actionButtonLabel: 'Save',
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: <Widget>[
            Text(
              'အဝင်စာရင်း',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'ရက်စွဲ - ' + DateTime.now().ddMMyyyy,
            ),
            myInputForm(
              _nameCtrl,
              hintText: '',
              readOnly: true,
              margin: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
            myInputForm(
              _inCtrl,
              hintText: 'အရေအတွက်',
              fn: _fn,
              keyboardType: TextInputType.number,
              margin: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
