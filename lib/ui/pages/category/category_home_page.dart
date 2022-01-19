import '../../../lib_exp.dart';

class CategoryHomePage extends StatefulWidget {
  const CategoryHomePage({Key? key}) : super(key: key);

  @override
  _CategoryHomePageState createState() => _CategoryHomePageState();
}

class _CategoryHomePageState extends State<CategoryHomePage> {
  late CategoryCtrl _categoryCtrl;

  void _onAddPress() {
    AddCategoryDialog.show(
      context,
      title: 'အသစ်ထည့်',
      onPresss: (Product product) async {
        LoadingDialog.show(context);
        var resp = await DbCtrl.insertProduct(product);
        if (resp == ErrorResponse) {
          MyAlertDialog.show(
            context,
            type: AlertType.fail,
            onTapActionButton: () {
              LoadingDialog.hide(context);
            },
            title: 'Fail!',
            description: resp.message,
          );
        } else {
          LoadingDialog.hide(context);
        }
        _categoryCtrl.addProducts(product);
      },
    );
  }

  void _onUpdatePress({
    required int index,
    required String imgURl,
    required String name,
    required int price,
  }) {
    AddCategoryDialog.show(
      context,
      title: 'ပြင်မည်',
      btnLabel: 'Update',
      productName: name,
      productPrice: price.toString(),
      imgUrl: imgURl,
      onPresss: (Product product) {
        _categoryCtrl.updateProducts(index, product);
      },
    );
  }

  void _onRemovePress(int index) {
    _categoryCtrl.removeProducts(index);
  }

  @override
  void initState() {
    super.initState();
    _categoryCtrl = context.read<CategoryCtrl>();
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
        child: FutureBuilder<dynamic>(
          future: ProductsTable.getAll(),
          builder: (_, snapshot) {
            if (snapshot.data is ErrorResponse) {
              return Center(
                child: Text(snapshot.data.message),
              );
            }
            if (snapshot.data is List<Product>) {
              List<Product> products = snapshot.data;
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
                    label: products[index].name,
                    price: products[index].price,
                    isAdd: false,
                    onCloseBtnCallback: () => _onRemovePress(index),
                    onPress: () => _onUpdatePress(
                      index: index,
                      imgURl: products[index].imgURl ?? '',
                      name: products[index].name ?? '',
                      price: products[index].price ?? 0,
                    ),
                  );
                },
              );
            }
            return const LinearProgressIndicator();
          },
        ),
      );

  Widget _body() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Consumer<CategoryCtrl>(builder: (_, categoryCtrl, __) {
        final length = categoryCtrl.products.length;
        return GridView.builder(
          shrinkWrap: true,
          itemCount: length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (_, index) {
            if (index == length) {
              return MyItem(
                label: 'Add',
                isAdd: true,
                onPress: _onAddPress,
              );
            }
            return MyItem(
              imgUrl: categoryCtrl.products[index].imgURl,
              label: categoryCtrl.products[index].name,
              price: categoryCtrl.products[index].price,
              isAdd: false,
              onCloseBtnCallback: () => _onRemovePress(index),
              onPress: () => _onUpdatePress(
                index: index,
                imgURl: categoryCtrl.products[index].imgURl ?? '',
                name: categoryCtrl.products[index].name ?? '',
                price: categoryCtrl.products[index].price ?? 0,
              ),
            );
          },
        );
      }),
    );
  }
}
