import '../../../lib_exp.dart';

class SaleHomePage extends StatefulWidget {
  const SaleHomePage({Key? key}) : super(key: key);

  @override
  _SaleHomePageState createState() => _SaleHomePageState();
}

class _SaleHomePageState extends State<SaleHomePage> {
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  int _cartQuantityItems = 0;

  void listClick(GlobalKey gkImageContainer) async {
    await runAddToCardAnimation(gkImageContainer);
    await gkCart.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
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
        body: Center(
          child: Container(
            alignment: Alignment.center,
            height: 73,
            child: AddToCardItem(onClick: listClick, index: 1),
          ),
        ),
      ),
    );
  }
}
