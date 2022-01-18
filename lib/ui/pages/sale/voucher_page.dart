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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _textRow('နံပါတ်', widget.products.no.toString()),
                    _textRow('ရက်စွဲ', widget.products.date!.ddMMMhhmmAAA),
                    _textRow('အမျိုးအစား', widget.products.name),
                    _textRow('အရေအတွက်', widget.products.quentity.toString()),
                    _textRow(
                      'စျေးနှုန်း ($dia)',
                      widget.products.price.toString().currency,
                    ),
                    const Divider(thickness: 1),
                    _textRow(
                      'ကျသင့်ငွေ ($dia)',
                      widget.products.charge.toString().currency,
                    ),
                    const Divider(thickness: 1),
                    widget.products.note!.isNotEmpty
                        ? _textRow('မှတ်ချက်', widget.products.note)
                        : const SizedBox.shrink(),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
            MyButton(
              onTap: () {},
              label: 'Print',
            ),
            const SizedBox(height: 8),
          ],
        ),
      );

  Widget _textRow(String t1, String? t2) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('$t1 : '),
            Text(
              t2!,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
}
