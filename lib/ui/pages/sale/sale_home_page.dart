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
            InkWell(
              onTap: () => context.push(
                const CartPage(),
                // VoucherPage(
                //   products: _saleCtrl.getConfirmedCartList,
                //   totalAmount: _saleCtrl.totalAmount,
                // ),
              ),
              borderRadius: BorderRadius.circular(16),
              child: AddToCartIcon(
                key: gkCart,
                icon: const Icon(Icons.shopping_cart),
                colorBadge: Colors.red,
              ),
            ),
          ],
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() => Column(
        children: <Widget>[
          _listItemsView(),
          _footerRow(),
          const SizedBox(height: 16),
        ],
      );

  Widget _listItemsView() => Consumer<SaleCtrl>(
        builder: (_, ctrl, __) {
          return Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: ctrl.cartList.length,
              itemBuilder: (_, index) => AddToCardItem(
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
              ),
              separatorBuilder: (_, index) => const Divider(thickness: 1),
            ),
          );
        },
      );

  Widget _footerRow() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: context.width * 0.4,
              child: _totalWidget(),
            ),
            SizedBox(
              width: context.width * 0.5,
              child: MyButton(
                onTap: () => context.push(VoucherPage(
                  products: _saleCtrl.getConfirmedCartList,
                  totalAmount: _saleCtrl.totalAmount,
                )),
                label: 'Checkout',
              ),
            )
          ],
        ),
      );

  Widget _totalWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Total : ',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.pink[300],
            ),
          ),
          Consumer<SaleCtrl>(builder: (_, ctrl, __) {
            return Text(
              ctrl.totalAmount.toString().currency + ' $dia',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink[300],
              ),
            );
          }),
        ],
      );
}
