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
  List<String> _productNameList = [];
  late DbCtrl _dbCtrl;
  late DateTime fstDate;
  late DateTime lstDate;
  int _limit = voucherLimit;

  @override
  void initState() {
    super.initState();
    _dbCtrl = context.read<DbCtrl>();
    final ids = [allCategoryConst];
    for (var p in widget.products) {
      ids.add(p.name!);
    }
    _productNameList = [
      ...{...ids}
    ];
    final now = DateTime.now();
    fstDate = DateTime(now.year, now.month, now.day);
    lstDate = now;
    _setSelectedDateToCtrl(needToNotify: false);
  }

  @override
  void dispose() {
    _dbCtrl.resetQuery();

    super.dispose();
  }

  void _setSelectedDateToCtrl({bool needToNotify = true}) {
    _dbCtrl.setQuery(
      fstDate: fstDate,
      lstDate: lstDate,
      productName: _dbCtrl.pName,
      needToNotify: needToNotify,
    );
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
          MyDatePicker(
            needToAdd23Hours: false,
            onSelectedDateTime: (DateTime? date) async {
              fstDate = date!;
              _setSelectedDateToCtrl();
            },
          ),
          MyDatePicker(
            needToAdd23Hours: true,
            onSelectedDateTime: (DateTime? date) async {
              lstDate = date!;
              _setSelectedDateToCtrl();
            },
          ),
          SizedBox(
            width: context.width * 0.4,
            child: MyDropDown(
              list: _productNameList,
              onChanged: (String v) async {
                _dbCtrl.setQuery(
                  fstDate: fstDate,
                  lstDate: lstDate,
                  productName: v,
                  needToNotify: true,
                );
              },
            ),
          ),
        ],
      );

  Widget _fetchVoucherListView() {
    return Consumer<DbCtrl>(
      builder: (_, dbCtrl, __) {
        return FutureBuilder<dynamic>(
          future: _dbCtrl.findVoucher(),
          builder: (_, snapshot) {
            if (snapshot.data is ErrorResponse) {
              return Center(
                child: Text(snapshot.data.message),
              );
            }
            if (snapshot.data is List<VoucherModel>) {
              final List<VoucherModel> vouchers = snapshot.data;

              if (vouchers.isEmpty) {
                return _emptyCart();
              } else {
                int totalAmount = 0;
                for (VoucherModel v in vouchers) {
                  totalAmount += v.charge ?? 0;
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: vouchers.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      if (index == vouchers.length) {
                        return _totalItem(totalAmount);
                      }
                      return VoucherItem(
                        no: index + 1,
                        voucher: vouchers[index],
                        totalAmount: vouchers[index].charge,
                        note: vouchers[index].note,
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

  Widget _totalItem(int charge) => Column(
        children: <Widget>[
          MyButton(
            onTap: () {
              _limit += voucherLimit;
              _dbCtrl.setPage(_limit);
            },
            color: Colors.white,
            labelColor: AppColors.primaryColor,
            padding: const EdgeInsets.all(0),
            width: context.width / 2,
            label: 'Show More',
          ),
          Card(
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
                      fstDate.ddMMyyyy + ' မှ ' + lstDate.ddMMyyyy + ' ထိ',
                      style: TextStyle(color: Colors.grey[200]),
                    ),
                  ),
                  _textRow(
                      'ရောင်းရငွေ ($dia)', charge.toString().currency + dia),
                ],
              ),
            ),
          ),
        ],
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
