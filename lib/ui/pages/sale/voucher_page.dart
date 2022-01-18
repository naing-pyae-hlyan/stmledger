import 'package:stmledger/ui/widgets/voucher_item.dart';

import '../../../lib_exp.dart';

class VoucherPage extends StatefulWidget {
  final Products products;
  const VoucherPage({
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  _VoucherPageState createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  Future<void> _print() async {
    context.pushAndRemoveUntil(const HomePage());
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
                child: VoucherItem(
                  products: widget.products,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: MyButton(
                onTap: _print,
                label: 'Print',
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
}
