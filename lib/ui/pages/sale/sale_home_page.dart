import '../../../lib_exp.dart';

class SaleHomePage extends StatefulWidget {
  const SaleHomePage({Key? key}) : super(key: key);

  @override
  _SaleHomePageState createState() => _SaleHomePageState();
}

class _SaleHomePageState extends State<SaleHomePage> {
  final List<String> _productNameList = ['Select'];
  String _selectedName = 'Select';
  late CategoryCtrl _categoryCtrl;
  TextEditingController _quantityCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  TextEditingController _noteCtrl = TextEditingController();

  FocusNode _quantityFn = FocusNode();
  FocusNode _priceFn = FocusNode();
  FocusNode _noteFn = FocusNode();

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
    for (var p in _categoryCtrl.products) {
      _productNameList.add(p.name ?? '');
    }
    _selectedName = _productNameList[0];
    _quantityCtrl.text = '1';
  }

  void _dropDownValueChanged(dynamic s) {
    setState(() => _selectedName = s);
    for (var p in _categoryCtrl.products) {
      if (p.name == s) {
        _priceCtrl.text = p.price.toString();
        break;
      } else {
        _priceCtrl.clear();
      }
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _mText('အမျိုးအစား'),
              MyDropDown(
                selectedName: _selectedName,
                list: _productNameList,
                onChanged: _dropDownValueChanged,
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
              ActionButton(onTap: () {}, label: 'Ok'),
            ],
          ),
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
