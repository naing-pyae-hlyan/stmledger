import '../../../lib_exp.dart';

class CategoryHomePage extends StatefulWidget {
  const CategoryHomePage({Key? key}) : super(key: key);

  @override
  _CategoryHomePageState createState() => _CategoryHomePageState();
}

class _CategoryHomePageState extends State<CategoryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('အမျိုးအစားများ'),
        centerTitle: false,
      ),
      body: _addCategoryBtn(),
    );
  }

  Widget _addCategoryBtn() => InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.primaryColor,
          ),
          width: 120,
          height: 150,
        ),
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
      );
}
