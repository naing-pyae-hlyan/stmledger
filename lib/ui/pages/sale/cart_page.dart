import '../../../lib_exp.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('လှည်း'),
        automaticallyImplyLeading: true,
        centerTitle: false,
      ),
      body: _body(),
    );
  }

  Widget _body() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/icons/empty_cart.png',
              width: context.width * 0.6,
              height: context.width * 0.6,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),
            Text(
              'Empty Cart',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      );
}
