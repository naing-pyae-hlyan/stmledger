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
  List<MyDropDownModel> _productNameList = [];
  MyDropDownModel _selectedValue = allCategoryConst;
  late DbCtrl _dbCtrl;
  int? fstDate;
  int? lstDate;

  @override
  void initState() {
    super.initState();
    _dbCtrl = context.read<DbCtrl>();
    final Map<String, MyDropDownModel> ids = {};
    for (var p in widget.products) {
      ids[p.name!] = MyDropDownModel(value: p.name, key: p.id);
    }
    _productNameList = ids.values.toList();
    _selectedValue = _productNameList[0];
    fstDate = null;
    lstDate = null;
  }

  @override
  void dispose() {
    _dbCtrl.resetQuery();

    super.dispose();
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

  Widget _body() => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _haderRow(),
            const SizedBox(height: 8),
            _fetchVoucherListView(),
          ],
        ),
      );

  Widget _haderRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MyDatePicker(onSelectedDateTime: (DateTime? date) {
            fstDate = date?.millisecondsSinceEpoch;
            _dbCtrl.setQuery(
              fstDate: fstDate,
              productId: _dbCtrl.productId,
              needCallDBandNotify: false,
            );
          }),
          MyDatePicker(onSelectedDateTime: (DateTime? date) {
            lstDate = date?.millisecondsSinceEpoch;
            _dbCtrl.setQuery(
              fstDate: fstDate,
              lstDate: lstDate,
              productId: _dbCtrl.productId,
              needCallDBandNotify: true,
            );
          }),
          SizedBox(
            width: context.width * 0.4,
            child: MyDropDown(
              selectedName: _selectedValue,
              list: _productNameList,
              onChanged: (MyDropDownModel v) => setState(() {
                _selectedValue = v;
                _dbCtrl.setQuery(
                  productId: v.key,
                  fstDate: fstDate,
                  lstDate: lstDate,
                  needCallDBandNotify: true,
                );
              }),
            ),
          ),
        ],
      );

  Widget _fetchVoucherListView() {
    return Consumer<DbCtrl>(
      builder: (_, dbCtrl, __) {
        return FutureBuilder<dynamic>(
          future: _dbCtrl.find(),
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
                return Expanded(
                  child: ListView.builder(
                    itemCount: voucher.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      if (index == voucher.length) {
                        return _totalItem(totalAmount);
                      }
                      return VoucherItem(
                        products: convertVoucherModelToProduct(voucher[index]),
                        totalAmount: voucher[index].charge,
                        note: voucher[index].note,
                      );
                    },
                  ),
                );
              }
            }

            return const LinearProgressIndicator();
          },
        );
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

  Widget _emptyCart() => Flexible(
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
              'No result',
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
