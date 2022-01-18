import '../../lib_exp.dart';

class MyItem extends StatelessWidget {
  final String? imgUrl;
  final String? label;
  final VoidCallback onPress;
  final Color? color;
  final bool isAdd;
  final int? price;
  const MyItem({
    required this.label,
    this.imgUrl,
    required this.onPress,
    this.color,
    this.isAdd = false,
    this.price,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onPress,
              child: Container(
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color ?? AppColors.primaryColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      imgUrl ?? '',
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) {
                        if (isAdd) {
                          return const Icon(
                            Icons.add,
                            size: 64,
                            color: Colors.white,
                          );
                        }
                        return const Icon(
                          Icons.more_horiz,
                          size: 64,
                          color: Colors.white,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            price != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 8),
                    child: Text(
                      '$price'.currency + ' $dia',
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label!,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
