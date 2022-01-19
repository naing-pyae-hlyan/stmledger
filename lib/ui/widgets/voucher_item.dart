import '../../lib_exp.dart';

class VoucherItem extends StatelessWidget {
  final List<Product>? products;
  final int? totalAmount;
  const VoucherItem({
    required this.products,
    required this.totalAmount,
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
            _textRow(
              'ရက်စွဲ',
              DateTime.now().ddMMMhhmmAAA,
            ),
            _textRow('အမျိုးအစားများ', 'Qty / Price'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products?.length,
              itemBuilder: (_, index) => _textRow(
                products![index].name!,
                products![index].qty.toString() +
                    ' x ' +
                    products![index].price.toString().currency,
              ),
            ),
            const Divider(thickness: 1),
            _textRow(
              'ကျသင့်ငွေ ($dia)',
              (totalAmount ?? '').toString().currency + dia,
            ),
          ],
        ),
      ),
    );
  }

  Widget _textRow(String t1, String? t2) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('$t1 : '),
            Flexible(
              child: Text(
                t2 ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 5,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      );
}
