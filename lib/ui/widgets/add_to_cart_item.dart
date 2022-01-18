import '../../lib_exp.dart';

class AddToCardItem extends StatelessWidget {
  final GlobalKey imageGlobalKey = GlobalKey();
  final Products products;
  final void Function(GlobalKey) onClick;
  AddToCardItem({
    required this.products,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onClick(imageGlobalKey),
      leading: MyCircleImage(
        assetImage: products.imgURl,
      ),
      title: Text(
        products.names?[0] ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        softWrap: true,
      ),
      subtitle: Text(
        (products.price?.toString() ?? '').currency + ' $dia',
        style: TextStyle(
          fontSize: 12,
          color: Colors.pink[300],
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: _trailing(),
    );
  }

  Widget _trailing() => Column(
        children: <Widget>[
          Text(
            'Qty',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.primaryColor.withOpacity(0.8),
            ),
          ),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _trailingBtn(
                  () {},
                  icon: Icons.add,
                ),
                const Text('1'),
                _trailingBtn(
                  () {},
                  icon: Icons.remove,
                ),
              ],
            ),
          ),
        ],
      );

  Widget _trailingBtn(VoidCallback callback, {required IconData icon}) =>
      InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: callback,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: AppColors.primaryColor,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      );
}
