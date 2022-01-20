import 'package:stmledger/ui/widgets/voucher_item.dart';

import '../../../lib_exp.dart';

class SummaryHomePage extends StatefulWidget {
  final List<Product> products;
  const SummaryHomePage({
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  _SummaryHomePageState createState() => _SummaryHomePageState();
}

class _SummaryHomePageState extends State<SummaryHomePage> {
  final List<String> _productNameList = ['All'];
  String _selectedName = 'All';
  late DbCtrl _dbCtrl;

  @override
  void initState() {
    super.initState();
    _dbCtrl = context.read<DbCtrl>();
    for (var p in widget.products) {
      _productNameList.add(p.name ?? '');
    }
    _selectedName = _productNameList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: const Text('စာရင်း'),
      ),
      body: _body(),
    );
  }

  Widget _haderRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MyDatePicker(onSelectedDateTime: (DateTime? date) {}),
          MyDatePicker(onSelectedDateTime: (DateTime? date) {}),
          SizedBox(
            width: context.width * 0.4,
            child: MyDropDown(
              selectedName: _selectedName,
              list: _productNameList,
              onChanged: (v) => setState(() => _selectedName = v),
            ),
          ),
        ],
      );

  Widget _body() {
    return FutureBuilder<dynamic>(
      future: _dbCtrl.getAllVoucher(),
      builder: (_, snapshot) {
        if (snapshot.data is ErrorResponse) {
          return Center(
            child: Text(snapshot.data.message),
          );
        }
        if (snapshot.data is List<VoucherModel>) {
          final List<VoucherModel> voucher = snapshot.data;

          if (voucher.isEmpty) {
            return _emptyCart();
          } else {
            int totalAmount = 0;
            for (VoucherModel v in voucher) {
              totalAmount += v.charge ?? 0;
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _haderRow(),
                  const SizedBox(height: 8),
                  Flexible(
                    child: ListView.builder(
                      itemCount: voucher.length + 1,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        if (index == voucher.length) {
                          return _totalItem(totalAmount);
                        }
                        return VoucherItem(
                          products:
                              convertVoucherModelToProduct(voucher[index]),
                          totalAmount: voucher[index].charge,
                          note: voucher[index].note,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }

        return const LinearProgressIndicator();
      },
    );
  }

  Widget _totalItem(int charge) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: AppColors.primaryColor,
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  DateTime.now().ddMMyyyy +
                      ' မှ ' +
                      DateTime.now().ddMMyyyy +
                      ' ထိ',
                  style: TextStyle(color: Colors.grey[200]),
                ),
              ),
              _textRow('ရောင်းရငွေ ($dia)', charge.toString().currency + dia),
            ],
          ),
        ),
      );

  Widget _textRow(String t1, String? t2) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '$t1 : ',
              style: TextStyle(color: Colors.grey[200]),
            ),
            Text(
              t2!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[200],
              ),
            ),
          ],
        ),
      );

  Widget _emptyCart() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/icons/empty.png',
              width: context.width * 0.5,
              height: context.width * 0.5,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),
            Text(
              'Empty Voucher',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      );
}
