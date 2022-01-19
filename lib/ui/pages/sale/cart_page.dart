import '../../../lib_exp.dart';

class CartPage extends StatefulWidget {
  final List<Product> products;
  final int totalAmount;
  const CartPage({
    required this.products,
    required this.totalAmount,
    Key? key,
  }) : super(key: key);

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
      body: widget.products.isEmpty ? _emptyCart() : _body(),
    );
  }

  Widget _body() => Column(
        children: <Widget>[
          _listItemsView(),
          _footerRow(),
        ],
      );

  Widget _listItemsView() => Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: widget.products.length + 1,
          itemBuilder: (_, index) {
            if (index == widget.products.length) return const SizedBox.shrink();
            return _item(widget.products[index]);
          },
          separatorBuilder: (_, index) => const Divider(thickness: 1),
        ),
      );

  Widget _emptyCart() => Center(
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

  Widget _item(Product product) => ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: MyCircleImage(
          assetImage: product.imgURl,
        ),
        title: Text(
          product.name ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          softWrap: true,
        ),
        subtitle: Text(
          (product.price?.toString() ?? '').currency + ' $dia',
          style: TextStyle(
            fontSize: 14,
            color: Colors.pink[300],
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: 'Qty\tx\t',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[400],
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: product.qty.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Charge\t\t',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[400],
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (product.price! * product.qty!).toString().currency +
                        dia,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                  onTap: () => context.push(
                    VoucherPage(
                      products: widget.products,
                      totalAmount: widget.totalAmount,
                    ),
                  ),
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
          Text(
            widget.totalAmount.toString().currency + ' $dia',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.pink[300],
            ),
          )
        ],
      );
}
