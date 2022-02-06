import '../../../lib_exp.dart';

class WarehouseHomePage extends StatefulWidget {
  final List<Product> products;
  const WarehouseHomePage({
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  _WarehouseHomePageState createState() => _WarehouseHomePageState();
}

class _WarehouseHomePageState extends State<WarehouseHomePage> {
  List<String> _productNameList = [];
  late DbCtrl _dbCtrl;
  late DateTime fstDate;
  late DateTime lstDate;

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
        title: const Text('ဂိုဒေါင်'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _haderRow(),
            SizedBox(height: 16),
            _futureWarehouseTable(),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                onTap: () {
                  WarehouseAddInstockDialog.show(
                    context,
                    dropDownList: widget.products,
                  );
                },
                label: 'Add',
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

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

  Widget _futureWarehouseTable() => Consumer<DbCtrl>(builder: (_, dbCtrl, __) {
        return FutureBuilder<dynamic>(
          future: _dbCtrl.findVoucher(),
          builder: (_, snapshot) {
            return Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  DataTable(
                    columnSpacing: 42,
                    border: TableBorder.all(
                      width: 0.4,
                      color: AppColors.primaryColor,
                    ),
                    columns: const <DataColumn>[
                      DataColumn(label: Text('အမည်')),
                      DataColumn(label: Text('ထုတ်')),
                      DataColumn(label: Text('ရောင်း')),
                      DataColumn(label: Text('လက်ကျန်')),
                    ],
                    rows: List<Product>.generate(1, (index) => Product())
                        .map<DataRow>((Product e) => DataRow(
                              cells: [
                                DataCell(Text(e.name.toString())),
                                DataCell(Text(e.price.toString())),
                                DataCell(Text(e.qty.toString())),
                                DataCell(Text(e.imgURl.toString())),
                              ],
                            ))
                        .toList(),
                  ),
                ],
              ),
            );
          },
        );
      });
}
