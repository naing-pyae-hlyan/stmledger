import '../../lib_exp.dart';

class AddToCardItem extends StatelessWidget {
  final GlobalKey imageGlobalKey = GlobalKey();
  final int index;
  final void Function(GlobalKey) onClick;
  AddToCardItem({
    required this.index,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onClick(imageGlobalKey),
      title: const Text('Helo'),
      leading: Container(
        key: imageGlobalKey,
        width: 60,
        height: 60,
        color: Colors.transparent,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
