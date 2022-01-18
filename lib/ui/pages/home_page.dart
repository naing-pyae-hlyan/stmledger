import '../../lib_exp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

void _onTapItem(BuildContext context, HomeTypeEnum type) {
  switch (type) {
    case HomeTypeEnum.category:
      context.push(const CategoryHomePage());
      break;
    case HomeTypeEnum.sale:
      context.push(const SaleHomePage());
      break;
    case HomeTypeEnum.summary:
      context.push(const SummaryHomePage());
      break;
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ရွှေသမင်မုန့်တိုက်'),
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
                itemBuilder: (_, index) => _gridItem(data: homeTypes[index]),
              ),
            ),
            CommonUtils.versionLabel(),
          ],
        ),
      ),
    );
  }

  Widget _gridItem({required HomeTypeModel data}) => Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _onTapItem(context, data.type!),
            child: Container(
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primaryColor,
              ),
              child: Image.asset(
                data.url!,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            data.name!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
}
