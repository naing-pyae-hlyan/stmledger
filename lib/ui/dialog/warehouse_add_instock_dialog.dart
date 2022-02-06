import '../../lib_exp.dart';

class WarehouseAddInstockDialog {
  static void show(
    BuildContext context, {
    required List<Product> dropDownList,
    required ValueChanged<WarehouseModel> onSave,
    Key? key,
  }) {
    final TextEditingController _inCtrl = TextEditingController();
    final FocusNode _fn = FocusNode();

    final List<String> _dropList = [];

    for (final d in dropDownList) {
      _dropList.add(d.name!);
    }
    String _selectedName = _dropList[0];

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
            iso8601Date: MyDateUtils.iso8601Date,
            productName: _selectedName,
            inStock: int.parse(_inCtrl.text),
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              child: MyDropDown(
                list: _dropList,
                needAllLabel: false,
                onChanged: (v) => _selectedName = v,
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
