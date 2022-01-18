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
        centerTitle: false,
        title: const Text('အမျိုးအစားများ'),
      ),
    );
  }
}
