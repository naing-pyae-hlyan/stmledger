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
      onPresss: (Products product) {
        _categoryCtrl.addProducts(product);
      },
    );
  }

  void _onUpdatePress({
    required int index,
    required String name,
    required int price,
  }) {
    AddCategoryDialog.show(
      context,
      title: 'ပြင်မည်',
      btnLabel: 'Update',
      productName: name,
      productPrice: price.toString(),
      onPresss: (Products product) {
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
      body: _body(),
    );
  }

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
              label: categoryCtrl.products[index].names?[0],
              price: categoryCtrl.products[index].price,
              isAdd: false,
              onCloseBtnCallback: () => _onRemovePress(index),
              onPress: () => _onUpdatePress(
                index: index,
                name: categoryCtrl.products[index].names?[0] ?? '',
                price: categoryCtrl.products[index].price ?? 0,
              ),
            );
          },
        );
      }),
    );
  }
}
