import '../../../lib_exp.dart';

class CategoryHomePage extends StatefulWidget {
  const CategoryHomePage({Key? key}) : super(key: key);

  @override
  _CategoryHomePageState createState() => _CategoryHomePageState();
}

class _CategoryHomePageState extends State<CategoryHomePage> {
  void _onAddPress() {
    AddCategoryDialog.show(
      context,
      title: 'အသစ်ထည့်',
      onPresss: (Products map) {},
    );
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
    const length = 4;
    return Container(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
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
            label: 'ကြက်ဥလိပ်',
            isAdd: false,
            price: 1000,
            onPress: () {},
          );
        },
      ),
    );
  }
}
