import '../../lib_exp.dart';

class VoucherItem extends StatelessWidget {
  final Products? products;
  const VoucherItem({
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            _textRow('နံပါတ်', (products?.no ?? '').toString()),
            _textRow(
              'ရက်စွဲ',
              products?.date != null ? products?.date!.ddMMMhhmmAAA : '',
            ),
            _textRow('အမျိုးအစား', products?.name ?? ''),
            _textRow('အရေအတွက်', (products?.quentity ?? '').toString()),
            _textRow(
              'စျေးနှုန်း ($dia)',
              (products?.price ?? '').toString().currency,
            ),
            const Divider(thickness: 1),
            _textRow(
              'ကျသင့်ငွေ ($dia)',
              (products?.charge ?? '').toString().currency,
            ),
            const Divider(thickness: 1),
            (products?.note != null && products!.note!.isNotEmpty)
                ? _textRow('မှတ်ချက်', products?.note)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _textRow(String t1, String? t2) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('$t1 : '),
            Text(
              t2 ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
}
