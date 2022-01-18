import '../../../lib_exp.dart';

class SummaryHomePage extends StatefulWidget {
  const SummaryHomePage({Key? key}) : super(key: key);

  @override
  _SummaryHomePageState createState() => _SummaryHomePageState();
}

class _SummaryHomePageState extends State<SummaryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: const Text('စာရင်း'),
      ),
    );
  }
}
