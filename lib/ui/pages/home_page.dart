import '../../lib_exp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ရွှေသမင်မုန့်တိုက်'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _iconRow(
                img1: 'assets/bakery.png',
                name1: 'အမျိုးအစားများ',
                onPress1: () => context.push(const CategoryHomePage()),
                img2: 'assets/text-file.png',
                name2: 'စာရင်းချုပ်',
                onPress2: () {},
              ),
              _iconRow(
                img1: 'assets/bakery.png',
                name1: 'အမျိုးအစားများ',
                onPress1: () {},
                img2: 'assets/text-file.png',
                name2: 'စာရင်းချုပ်',
                onPress2: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconRow({
    required String img1,
    required String img2,
    required String name1,
    required String name2,
    required VoidCallback onPress1,
    required VoidCallback onPress2,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _iconButton(
            img: img1,
            name: name1,
            onPress: onPress1,
          ),
          _iconButton(
            img: img2,
            name: name2,
            onPress: onPress2,
          ),
        ],
      );

  Widget _iconButton({
    required String img,
    required String name,
    required VoidCallback onPress,
  }) =>
      Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onPress,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primaryColor,
              ),
              height: context.width / 2.5,
              width: context.width / 3,
              child: Image.asset(
                img,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
}
