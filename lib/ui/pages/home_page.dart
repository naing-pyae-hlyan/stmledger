import '../../lib_exp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DbCtrl _dbCtrl;

  Future<void> _getProductsListFromDb(HomeTypeEnum type) async {
    final List<Product> products = await _dbCtrl.getAllProductList();
    final now = DateTime.now();
    _dbCtrl.setQuery(
      fstDate: DateTime(now.year, now.month, now.day),
      lstDate: now,
      needToNotify: false,
    );
    final List<WarehouseModel> warehouse =
        await _dbCtrl.findWarehouse(products: products);
    if (products.isEmpty && warehouse.isEmpty) {
      DialogUtils.errorDialog(
        context,
        'ကုန်ပစ္စည်းများမရှိသေးပါ။\nအမျိုးအစားများထဲတွင် ပစ္စည်းအသစ်များ\nထည့်သွင်းနိုင်ပါသည်။',
        alertType: AlertType.warning,
        title: 'Warning!',
      );
      return;
    } else if (warehouse.isNotEmpty && type == HomeTypeEnum.sale) {
      for (final w in warehouse) {
        if (w.inStock == 0) {
          DialogUtils.errorDialog(
            context,
            DateTime.now().ddMMyyyy +
                ' အတွက် ${w.productName} အရေအတွက် မသတ်မှတ်ရသေးပါ။\nဂိုထောင်ထဲတွင် ထည့်သွင်းနိုင်ပါသည်။',
            alertType: AlertType.warning,
            title: 'Warning!',
          );
          return;
        }
      }
      context.push(BaseSaleHomePage(
        products: products,
        warehouses: warehouse,
      ));
    } else if (type == HomeTypeEnum.warehouse) {
      context.push(WarehouseHomePage(products: products));
      return;
    } else if (type == HomeTypeEnum.summary) {
      context.push(SummaryHomePage(products: products));
      return;
    }
  }

  void _onTapItem(HomeTypeEnum type) {
    switch (type) {
      case HomeTypeEnum.category:
        context.push(const CategoryHomePage());
        break;
      case HomeTypeEnum.warehouse:
        _getProductsListFromDb(HomeTypeEnum.warehouse);
        break;
      case HomeTypeEnum.sale:
        _getProductsListFromDb(HomeTypeEnum.sale);
        break;
      case HomeTypeEnum.summary:
        _getProductsListFromDb(HomeTypeEnum.summary);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _dbCtrl = context.read<DbCtrl>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ledger'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: homeTypes.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (_, index) {
                    if (index == homeTypes.length) {
                      return MyItem(
                        label: 'ဖျက်ရန်',
                        imgUrl: '',
                        onPress: () => CommonUtils.clearAllData(),
                      );
                    }
                    return MyItem(
                      label: homeTypes[index].name,
                      imgUrl: homeTypes[index].url,
                      onPress: () => _onTapItem(homeTypes[index].type!),
                    );
                  }),
            ),
            CommonUtils.versionLabel(),
          ],
        ),
      ),
    );
  }
}
