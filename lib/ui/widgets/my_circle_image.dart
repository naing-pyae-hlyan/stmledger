import '../../lib_exp.dart';

class MyCircleImageWithGeneratedImage extends StatefulWidget {
  final Color? bgColor;
  final String? imgUrl;
  const MyCircleImageWithGeneratedImage({
    this.imgUrl,
    this.bgColor,
    Key? key,
  }) : super(key: key);
  @override
  _MyCircleImageWithGeneratedImageState createState() =>
      _MyCircleImageWithGeneratedImageState();
}

class _MyCircleImageWithGeneratedImageState
    extends State<MyCircleImageWithGeneratedImage> {
  @override
  Widget build(BuildContext context) {
    context.read<RandomImageCtrl>().setImageURl(widget.imgUrl);
    return Consumer<RandomImageCtrl>(builder: (_, ctrl, __) {
      return InkWell(
        onTap: () => ctrl.createRandomImageUrl(),
        borderRadius: BorderRadius.circular(32),
        child: MyCircleImage(
          assetImage: ctrl.randomImage,
          bgColor: widget.bgColor,
        ),
      );
    });
  }
}

class MyCircleImage extends StatefulWidget {
  final String? assetImage;
  final Color? bgColor;
  const MyCircleImage({
    required this.assetImage,
    this.bgColor,
    Key? key,
  }) : super(key: key);

  @override
  _MyCircleImageState createState() => _MyCircleImageState();
}

class _MyCircleImageState extends State<MyCircleImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        color: widget.bgColor ?? AppColors.primaryColor,
        child: Image.asset(
          widget.assetImage ?? '',
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) {
            return const Icon(
              Icons.more_horiz,
              size: 64,
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}
