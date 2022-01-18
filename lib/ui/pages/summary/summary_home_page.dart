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

  Future<void> _pickDateTime({required bool isStartDate}) async {}

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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            _haderRow(),
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
}
