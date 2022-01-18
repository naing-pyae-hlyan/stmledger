import '../../lib_exp.dart';

class MyItem extends StatelessWidget {
  final String? imgUrl;
  final String? label;
  final VoidCallback onPress;
  final Color? color;
  final bool isAdd;
  const MyItem({
    required this.label,
    this.imgUrl,
    required this.onPress,
    this.color,
    this.isAdd = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: Image.asset(
              imgUrl ?? '',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                if (isAdd) {
                  return const Icon(
                    Icons.add,
                    size: 48,
                    color: Colors.white,
                  );
                }
                return const Icon(
                  Icons.more_horiz,
                  size: 48,
                  color: Colors.white,
                );
              },
            ),
          ),
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
