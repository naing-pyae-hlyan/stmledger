import '../../lib_exp.dart';

class VoucherItem extends StatelessWidget {
  final VoucherModel voucher;
  final int? totalAmount;
  final int? no;
  final String? note;
  final bool popupPrint;
  final Function()? printClick;
  const VoucherItem({
    this.no,
    required this.voucher,
    required this.totalAmount,
    this.note,
    this.popupPrint = false,
    this.printClick,
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
            no != null ? _textRow('စဥ်', no.toString()) : SizedBox.shrink(),
            _textRow(
                'ရက်စွဲ',
                MyDateUtils.convertIso8601StringToDateTime(voucher.iso8601Date)
                    .ddMMMhhmmAAA),
            _textRow('အမျိုးအစားများ', 'Qty / Price'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: voucher.products!.length,
              itemBuilder: (_, index) => _textRow(
                voucher.products![index].name!,
                voucher.products![index].qty.toString() +
                    ' x ' +
                    voucher.products![index].price.toString().currency,
              ),
            ),
            const Divider(thickness: 1),
            _textRow(
              'ကျသင့်ငွေ ($dia)',
              (totalAmount ?? '').toString().currency + dia,
            ),
            note != null ? _textRow('မှတ်ချက်', note) : const SizedBox.shrink(),
            popupPrint
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MyButton(
                        label: 'Print',
                        padding: EdgeInsets.zero,
                        width: 64,
                        child: Icon(Icons.print),
                        onTap: printClick ?? () {},
                      ),
                    ),
                  )
                : SizedBox.shrink(),
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
