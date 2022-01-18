import 'package:stmledger/ui/widgets/voucher_item.dart';

import '../../../lib_exp.dart';

class SummaryHomePage extends StatefulWidget {
  const SummaryHomePage({Key? key}) : super(key: key);

  @override
  _SummaryHomePageState createState() => _SummaryHomePageState();
}

class _SummaryHomePageState extends State<SummaryHomePage> {
  final List<String> _productNameList = ['All'];
  String _selectedName = 'All';
  late CategoryCtrl _categoryCtrl;

  @override
  void initState() {
    super.initState();
    _categoryCtrl = context.read<CategoryCtrl>();
    for (var p in _categoryCtrl.products) {
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

  Widget _body() => Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            _haderRow(),
            const SizedBox(height: 8),
            _itemListView(),
          ],
        ),
      );

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

  Widget _itemListView() {
    const int length = 10;
    return Flexible(
      child: ListView.builder(
        itemCount: length + 1,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          if (index == length) {
            return _totalItem();
          }
          return VoucherItem(
            products: Products(),
          );
        },
      ),
    );
  }

  Widget _totalItem() => Card(
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
              _textRow('အရေအတွက်', '1000'),
              _textRow('ရောင်းရငွေ ($dia)', '10000'.currency),
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
}
