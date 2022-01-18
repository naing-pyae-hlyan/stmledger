import '../../../lib_exp.dart';

class BaseSaleHomePage extends StatelessWidget {
  const BaseSaleHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaleCtrl()),
      ],
      child: SaleHomePage(
        key: key,
      ),
    );
  }
}

class SaleHomePage extends StatefulWidget {
  const SaleHomePage({Key? key}) : super(key: key);

  @override
  _SaleHomePageState createState() => _SaleHomePageState();
}

class _SaleHomePageState extends State<SaleHomePage> {
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  List<GlobalKey> imageGlobalKeyList = [];
  late SaleCtrl _saleCtrl;

  late Function(GlobalKey) runAddToCardAnimation;

  void onAddClick(GlobalKey gkImageContainer, {required int count}) async {
    await runAddToCardAnimation(gkImageContainer);
    await gkCart.currentState!.runCartAnimation((count).toString());
  }

  void onReduceClick(GlobalKey gkImageContainer, {required int count}) async {
    await gkCart.currentState!.runCartAnimation((count).toString());
  }

  @override
  void initState() {
    super.initState();
    imageGlobalKeyList = List<GlobalKey>.generate(
      context.read<CategoryCtrl>().products.length,
      (index) => GlobalKey(),
    );
    _saleCtrl = context.read<SaleCtrl>();
    _saleCtrl.initCart(context.read<CategoryCtrl>().products);
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      gkCart: gkCart,
      rotation: false,
      dragToCardCurve: Curves.easeIn,
      dragToCardDuration: const Duration(milliseconds: 1000),
      previewCurve: Curves.linearToEaseOut,
      previewDuration: const Duration(milliseconds: 500),
      previewHeight: 30,
      previewWidth: 30,
      opacity: 0.85,
      initiaJump: false,
      receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) =>
          runAddToCardAnimation = addToCardAnimationMethod,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: false,
            title: const Text('အရောင်း'),
            actions: [
              AddToCartIcon(
                key: gkCart,
                icon: const Icon(Icons.shopping_cart),
                colorBadge: Colors.red,
              ),
            ],
          ),
          body: _bodyWidget()),
    );
  }

  Widget _bodyWidget() => Consumer<SaleCtrl>(
        builder: (_, ctrl, __) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: ctrl.cartList.length + 1,
            itemBuilder: (_, index) {
              if (index == ctrl.cartList.length) {
                return _totalWidget();
              }
              return AddToCardItem(
                products: ctrl.cartList[index],
                onAddClick: (key) {
                  ctrl.addQty(index);
                  onAddClick(key, count: ctrl.cartCounter);
                },
                onReduceClick: (key) {
                  ctrl.removeQty(index);
                  onReduceClick(key, count: ctrl.cartCounter);
                },
                globalKey: imageGlobalKeyList[index],
              );
            },
            separatorBuilder: (_, index) => const Divider(thickness: 1),
          );
        },
      );

  Widget _totalWidget() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Total : ',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.pink[300],
                ),
              ),
              Text(
                '1000 $dia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[300],
                ),
              ),
            ],
          ),
        ),
      );
}
