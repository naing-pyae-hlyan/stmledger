import '../../lib_exp.dart';

class AddToCardItem extends StatelessWidget {
  final Products products;
  final GlobalKey globalKey;
  final void Function(GlobalKey) onAddClick;
  final void Function(GlobalKey) onReduceClick;
  const AddToCardItem({
    required this.products,
    required this.onAddClick,
    required this.onReduceClick,
    required this.globalKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: MyCircleImage(
        globalKey: globalKey,
        assetImage: products.imgURl,
      ),
      title: Text(
        products.name ?? '',
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
                  () => onAddClick(globalKey),
                  icon: Icons.add,
                ),
                Text(
                  products.qty!.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                _trailingBtn(
                  () => onReduceClick(globalKey),
                  icon: Icons.remove,
                ),
              ],
            ),
          )
        ],
      );

  Widget _trailingBtn(VoidCallback callback, {required IconData icon}) =>
      InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: callback,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: AppColors.primaryColor,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      );
}
