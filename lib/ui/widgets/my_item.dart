import '../../lib_exp.dart';

class MyItem extends StatefulWidget {
  final String? imgUrl;
  final String? label;
  final VoidCallback onPress;
  final VoidCallback? onCloseBtnCallback;
  final Color? color;
  final bool isAdd;
  final int? price;
  const MyItem({
    required this.label,
    this.imgUrl,
    required this.onPress,
    this.color,
    this.isAdd = false,
    this.onCloseBtnCallback,
    this.price,
    Key? key,
  }) : super(key: key);

  @override
  State<MyItem> createState() => _MyItemState();
}

class _MyItemState extends State<MyItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemPressStateCtrl>(builder: (_, stateCtrl, __) {
      return Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  _card(stateCtrl),
                  widget.price != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 16, bottom: 8),
                          child: Text(
                            '${widget.price}'.currency + ' $dia',
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
              stateCtrl.state ? _closeButton() : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            widget.label!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      );
    });
  }

  Widget _card(ItemPressStateCtrl stateCtrl) => InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: widget.onPress,
        onLongPress: () {
          if (widget.onCloseBtnCallback != null) {
            stateCtrl.stateChange();
          }
        },
        child: Container(
          margin: const EdgeInsets.only(right: 8, top: 8),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.color ?? AppColors.primaryColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                widget.imgUrl ?? '',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  if (widget.isAdd) {
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
      );

  Widget _closeButton() {
    if (widget.onCloseBtnCallback == null) return const SizedBox.shrink();
    return Positioned(
      right: 0,
      top: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onCloseBtnCallback,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: AppColors.primaryColor,
                ),
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Icon(
                Icons.close_rounded,
                size: 30,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
