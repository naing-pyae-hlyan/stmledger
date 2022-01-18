import '../../../lib_exp.dart';

class SaleHomePage extends StatefulWidget {
  const SaleHomePage({Key? key}) : super(key: key);

  @override
  _SaleHomePageState createState() => _SaleHomePageState();
}

class _SaleHomePageState extends State<SaleHomePage> {
  final List<String> _productNameList = [];
  final List<String> _selectedName = [];
  late CategoryCtrl _categoryCtrl;
  final TextEditingController _quantityCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();

  final FocusNode _quantityFn = FocusNode();
  final FocusNode _priceFn = FocusNode();
  final FocusNode _noteFn = FocusNode();
  FToast? fToast;

  Future<void> _voucher() async {
    if (_selectedName.isEmpty) {
      showToast(fToast, msg: 'အမျိုးအစားရွေးပါ။', alertType: AlertType.warning);
      return;
    } else if (_quantityCtrl.text.isEmpty) {
      _quantityFn.requestFocus();
      showToast(fToast, msg: 'အရေအတွက်ထည့်ပါ။', alertType: AlertType.warning);
      return;
    } else {
      int q = int.parse(_quantityCtrl.text);
      int p = int.parse(_priceCtrl.text);
      context.push(VoucherPage(
        products: Products(
          no: 1,
          date: DateTime.now(),
          names: _selectedName,
          quentity: q,
          price: p,
          charge: (q * p),
          note: _noteCtrl.text,
        ),
      ));
    }
  }

  @override
  void dispose() {
    _quantityCtrl.dispose();
    _priceCtrl.dispose();
    _noteCtrl.dispose();
    _quantityFn.dispose();
    _priceFn.dispose();
    _noteFn.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _categoryCtrl = context.read<CategoryCtrl>();
    fToast = FToast();
    fToast?.init(context);
    for (var p in _categoryCtrl.products) {
      _productNameList.add(p.names?[0] ?? '');
    }
    _quantityCtrl.text = '1';
  }

  void _dropDownValueChanged(dynamic value) {
    if (value is List) {
      _selectedName.clear();
      int totalPrice = 0;
      for (var s in value) {
        for (var product in _categoryCtrl.products) {
          if (s == product.names?[0]) {
            _selectedName.add(s);
            totalPrice += product.price ?? 0;
          }
        }
      }
      (totalPrice > 0)
          ? _priceCtrl.text = totalPrice.toString()
          : _priceCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: const Text('အရောင်း'),
      ),
      body: _body(),
    );
  }

  Widget _body() => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _mText('အမျိုးအစား'),
                    MyMultiDropDown(
                      title: 'Select',
                      items: _productNameList,
                      onSelected: _dropDownValueChanged,
                    ),
                    const SizedBox(height: 16),
                    _mText('အရေအတွက်'),
                    myInputForm(
                      _quantityCtrl,
                      fn: _quantityFn,
                      hintText: 'Quantity',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _mText('ဈေးနှုန်း ($dia)'),
                    myInputForm(
                      _priceCtrl,
                      fn: _priceFn,
                      hintText: '\$ Price',
                      readOnly: true,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _mText('မှတ်ချက်'),
                    myInputForm(
                      _noteCtrl,
                      fn: _noteFn,
                      hintText: 'Note',
                      maxLine: 4,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MyButton(
                  onTap: _voucher,
                  label: 'ထည့်',
                  width: context.width * 0.4,
                  padding: const EdgeInsets.all(8),
                  color: AppColors.primaryColor.withOpacity(0.7),
                ),
                MyButton(
                  onTap: _voucher,
                  label: 'ဘောင်ချာ',
                  width: context.width * 0.4,
                  padding: const EdgeInsets.all(8),
                )
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      );

  Widget _mText(String t) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          t,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      );
}
