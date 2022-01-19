import '../../../lib_exp.dart';

class BaseSaleHomePage extends StatelessWidget {
  final List<Product> products;
  const BaseSaleHomePage({
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaleCtrl()),
      ],
      child: SaleHomePage(
        key: key,
        products: products,
      ),
    );
  }
}

class SaleHomePage extends StatefulWidget {
  final List<Product> products;
  const SaleHomePage({
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  _SaleHomePageState createState() => _SaleHomePageState();
}

class _SaleHomePageState extends State<SaleHomePage> {
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  List<GlobalKey> imageGlobalKeyList = [];
  late FToast _fToast;
  late SaleCtrl _saleCtrl;

  late Function(GlobalKey) runAddToCardAnimation;

  void onAddClick(GlobalKey gkImageContainer, {required int count}) async {
    await runAddToCardAnimation(gkImageContainer);
    await gkCart.currentState!.runCartAnimation((count).toString());
  }

  void onReduceClick(GlobalKey gkImageContainer, {required int count}) async {
    await gkCart.currentState!.runCartAnimation((count).toString());
  }

  void onCheckoutClick() {
    if (_saleCtrl.getConfirmedCartList.isNotEmpty &&
        _saleCtrl.totalAmount > 0) {
      context.push(
        VoucherPage(
          products: _saleCtrl.getConfirmedCartList,
          totalAmount: _saleCtrl.totalAmount,
        ),
      );
    } else {
      showToast(
        _fToast,
        msg: 'အနည်းဆုံး ပစ္စည်းတစ်ခုကို ခြင်းထဲသို့ထည့်ပါ။',
        gravity: ToastGravity.BOTTOM,
        alertType: AlertType.warning,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    imageGlobalKeyList = List<GlobalKey>.generate(
      widget.products.length,
      (index) => GlobalKey(),
    );
    _saleCtrl = context.read<SaleCtrl>();
    _saleCtrl.initCart(widget.products);
    _fToast = FToast();
    _fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      gkCart: gkCart,
      rotation: false,
      dragToCardCurve: Curves.easeIn,
      dragToCardDuration: const Duration(milliseconds: 500),
      previewCurve: Curves.linearToEaseOut,
      previewDuration: const Duration(milliseconds: 100),
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
                CartPage(
                  products: _saleCtrl.getConfirmedCartList,
                  totalAmount: _saleCtrl.totalAmount,
                ),
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
        ],
      );

  Widget _listItemsView() => Consumer<SaleCtrl>(
        builder: (_, ctrl, __) {
          final List<Product> products = ctrl.cartList;
          return Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: products.length + 1,
              itemBuilder: (_, index) {
                if (index == products.length) return const SizedBox.shrink();
                return AddToCardItem(
                  products: products[index],
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
            ),
          );
        },
      );

  Widget _footerRow() => Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
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
                  onTap: onCheckoutClick,
                  label: 'Checkout',
                ),
              )
            ],
          ),
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
              color: Colors.pink[200],
            ),
          ),
          Consumer<SaleCtrl>(builder: (_, ctrl, __) {
            return Text(
              ctrl.totalAmount.toString().currency + ' $dia',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.pink[300],
              ),
            );
          }),
        ],
      );
}
