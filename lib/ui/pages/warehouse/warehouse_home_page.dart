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

  void _onSavePress(WarehouseModel m) async {
    // await WarehouseTable.deleteAll();
    // _dbCtrl.refreshUI();
    // return;
    print(m.id);
    WarehouseAddInstockDialog.show(context, warehouseModel: m,
        onSave: (WarehouseModel warehouse) async {
      var resp = await _dbCtrl.updateWarehouse(warehouse);
      (resp is ErrorResponse)
          ? DialogUtils.errorDialog(context, resp)
          : _dbCtrl.refreshUI();
    });
  }

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
        title: const Text('ဂိုထောင်'),
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
          future: dbCtrl.findWarehouse(
            products: widget.products,
          ),
          builder: (_, snapshot) {
            if (snapshot.data is ErrorResponse) {
              return Center(
                child: Text(snapshot.data.message),
              );
            }
            if (snapshot.data is List<WarehouseModel>) {
              final List<WarehouseModel> warehouse = snapshot.data;
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
                      rows: warehouse
                          .map<DataRow>((WarehouseModel w) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(w.productName.toString()),
                                    onTap: () => _onSavePress(w),
                                  ),
                                  DataCell(
                                    Text(w.inStock.toString()),
                                    onTap: () => _onSavePress(w),
                                  ),
                                  DataCell(
                                    Text(w.outStock.toString()),
                                    onTap: () => _onSavePress(w),
                                  ),
                                  DataCell(Text(
                                    (w.inStock! - w.outStock!).toString(),
                                    style: TextStyle(
                                      color:
                                          _stockColor(w.inStock!, w.outStock!),
                                    ),
                                  )),
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            }
            return const LinearProgressIndicator();
          },
        );
      });

  Color _stockColor(int inS, int outS) {
    if (outS < (inS / 2)) {
      return Colors.green[800]!;
    } else if (outS == inS) {
      return Colors.red[800]!;
    } else if (outS > (inS / 2)) {
      return Colors.orange[800]!;
    }
    return Colors.black;
  }
}
