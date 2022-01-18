import '../../../lib_exp.dart';

class SaleHomePage extends StatefulWidget {
  const SaleHomePage({Key? key}) : super(key: key);

  @override
  _SaleHomePageState createState() => _SaleHomePageState();
}

class _SaleHomePageState extends State<SaleHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: const Text('အရောင်း'),
      ),
    );
  }
}
