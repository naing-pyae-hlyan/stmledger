import '../../lib_exp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _getProductsListFromDb(HomeTypeEnum type) async {
    final List<Product> resp = await context.read<DbCtrl>().getAllProductList();
    if (type == HomeTypeEnum.summary) {
      context.push(SummaryHomePage(products: resp));
      return;
    } else if (resp.isEmpty) {
      DialogUtils.errorDialog(
        context,
        'ကုန်ပစ္စည်းများမရှိသေးပါ။\nအမျိုးအစားများထဲတွင် ပစ္စည်းအသစ်များ\nထည့်သွင်းနိုင်ပါသည်။',
        alertType: AlertType.warning,
        title: 'Warning!',
      );
    } else {
      context.push(BaseSaleHomePage(products: resp));
    }
  }

  void _onTapItem(HomeTypeEnum type) {
    switch (type) {
      case HomeTypeEnum.category:
        context.push(const CategoryHomePage());
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
                itemCount: homeTypes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, index) => MyItem(
                  label: homeTypes[index].name,
                  imgUrl: homeTypes[index].url,
                  onPress: () => _onTapItem(homeTypes[index].type!),
                ),
              ),
            ),
            CommonUtils.versionLabel(),
          ],
        ),
      ),
    );
  }
}
