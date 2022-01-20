import 'package:stmledger/ui/widgets/voucher_item.dart';

import '../../../lib_exp.dart';

class VoucherPage extends StatefulWidget {
  final List<Product> products;
  final int? totalAmount;
  const VoucherPage({
    required this.products,
    required this.totalAmount,
    Key? key,
  }) : super(key: key);

  @override
  _VoucherPageState createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  final TextEditingController _noteCtrl = TextEditingController();
  late DbCtrl _dbCtrl;

  Future<void> _print() async {
    context.pushAndRemoveUntil(const HomePage());
  }

  @override
  void initState() {
    super.initState();
    _dbCtrl = context.read<DbCtrl>();
  }

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _voucher() async {
    final resp = await _dbCtrl.insertVoucher(
      products: widget.products,
      charge: widget.totalAmount!,
      note: _noteCtrl.text,
    );
    (resp is ErrorResponse)
        ? DialogUtils.errorDialog(context, resp)
        : MyAlertDialog.show(
            context,
            type: AlertType.success,
            title: 'Success',
            description:
                'ဘောင်ချာကို သိမ်းပြီးပါပြီ။\nစာရင်းထဲတွင် ပြန်လည်ကြည့်ရှူပါ။',
            addCloseButton: true,
            actionButtonLabel: 'Print',
            onTapActionButton: _print,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: const Text('ဘောင်ချာ'),
      ),
      body: _body(),
    );
  }

  Widget _body() => Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    VoucherItem(
                      products: widget.products,
                      totalAmount: widget.totalAmount,
                    ),
                    const SizedBox(height: 8),
                    myInputForm(
                      _noteCtrl,
                      hintText: 'မှတ်ချက်',
                      keyboardType: TextInputType.text,
                      maxLine: 5,
                      margin: const EdgeInsets.all(4),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: MyButton(
                onTap: _voucher,
                label: 'Save',
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
}
