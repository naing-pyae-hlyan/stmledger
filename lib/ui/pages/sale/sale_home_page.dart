import '../../../lib_exp.dart';

class SaleHomePage extends StatefulWidget {
  const SaleHomePage({Key? key}) : super(key: key);

  @override
  _SaleHomePageState createState() => _SaleHomePageState();
}

class _SaleHomePageState extends State<SaleHomePage> {
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  List<GlobalKey> imageGlobalKeyList = [];

  late Function(GlobalKey) runAddToCardAnimation;
  int _cartQuantityItems = 0;

  void onAddClick(GlobalKey gkImageContainer) async {
    await runAddToCardAnimation(gkImageContainer);
    await gkCart.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
  }

  void onReduceClick(GlobalKey gkImageContainer) async {
    await gkCart.currentState!
        .runCartAnimation((--_cartQuantityItems).toString());
  }

  @override
  void initState() {
    super.initState();
    imageGlobalKeyList = List<GlobalKey>.generate(
      context.read<CategoryCtrl>().products.length,
      (index) => GlobalKey(),
    );
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

  Widget _bodyWidget() => Consumer<CategoryCtrl>(
        builder: (_, ctrl, __) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: ctrl.products.length + 1,
            itemBuilder: (_, index) {
              if (index == ctrl.products.length) {
                return _totalWidget();
              }
              return AddToCardItem(
                products: ctrl.products[index],
                onAddClick: onAddClick,
                onReduceClick: onReduceClick,
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
