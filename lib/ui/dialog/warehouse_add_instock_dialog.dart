import '../../lib_exp.dart';

class WarehouseAddInstockDialog {
  static void show(
    BuildContext context, {
    required List<Product> dropDownList,
    Key? key,
  }) {
    final TextEditingController _inCtrl = TextEditingController();
    final List<String> _dropList = [];
    for (final d in dropDownList) {
      _dropList.add(d.name!);
    }
    BaseDialog.show(
      context,
      addCloseButton: true,
      onTapActionButtonNeedPop: false,
      onTapActionButton: () {},
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
                onChanged: (v) {},
              ),
            ),
            myInputForm(
              _inCtrl,
              hintText: 'အရေအတွက်',
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
