import '../../../lib_exp.dart';

class CategoryHomePage extends StatefulWidget {
  const CategoryHomePage({Key? key}) : super(key: key);

  @override
  _CategoryHomePageState createState() => _CategoryHomePageState();
}

class _CategoryHomePageState extends State<CategoryHomePage> {
  late DbCtrl _dbCtrl;

  void _onAddPress() {
    AddCategoryDialog.show(
      context,
      title: 'အသစ်ထည့်',
      onPresss: (Product product) async {
        var resp = await _dbCtrl.insertProduct(product);

        (resp is ErrorResponse)
            ? DialogUtils.errorDialog(context, resp)
            : _dbCtrl.refreshUI();
      },
    );
  }

  void _onUpdatePress({
    required int index,
    required Product product,
  }) {
    AddCategoryDialog.show(
      context,
      title: 'ပြင်မည်',
      btnLabel: 'Update',
      productName: product.name ?? '',
      productPrice: product.price.toString(),
      imgUrl: product.imgURl,
      id: product.id,
      onPresss: (Product p) async {
        var resp = await _dbCtrl.updateProduct(p);
        var resp2 = await _dbCtrl.updateNameOnly(
          productId: product.id!,
          newName: product.name ?? '',
        );
        (resp is ErrorResponse || resp2 is ErrorResponse)
            ? DialogUtils.errorDialog(context, resp)
            : _dbCtrl.refreshUI();
      },
    );
  }

  void _onRemovePress(int? id) async {
    if (id == null) return;
    var resp = await _dbCtrl.productDeleteById(id);
    var resp2 = await _dbCtrl.warehouseDeleteById(id);
    (resp is ErrorResponse || resp2 is ErrorResponse)
        ? DialogUtils.errorDialog(context, resp)
        : _dbCtrl.refreshUI();
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
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: const Text('အမျိုးအစားများ'),
      ),
      body: _futureBody(),
    );
  }

  Widget _futureBody() => Container(
        padding: const EdgeInsets.all(20),
        child: Consumer<DbCtrl>(builder: (_, ctrl, __) {
          return FutureBuilder<dynamic>(
            future: ctrl.getAllProductList(),
            builder: (_, snapshot) {
              if (snapshot.data is ErrorResponse) {
                return Center(
                  child: Text(snapshot.data.message),
                );
              }
              if (snapshot.data is List<Product>) {
                final List<Product> products = snapshot.data;
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: products.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (_, index) {
                    if (index == products.length) {
                      return MyItem(
                        label: 'Add',
                        isAdd: true,
                        onPress: _onAddPress,
                      );
                    }
                    return MyItem(
                      imgUrl: products[index].imgURl,
                      label: products[index].name! + ' #${products[index].id}',
                      price: products[index].price,
                      isAdd: false,
                      onCloseBtnCallback: () =>
                          _onRemovePress(products[index].id),
                      onPress: () => _onUpdatePress(
                          index: index, product: products[index]),
                    );
                  },
                );
              }
              return const LinearProgressIndicator();
            },
          );
        }),
      );
}
