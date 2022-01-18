import '../../lib_exp.dart';

class MyMultiDropDown extends StatefulWidget {
  final String title;
  final List<String> items;
  final ValueChanged<dynamic> onSelected;
  const MyMultiDropDown({
    required this.title,
    required this.items,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  _MyMultiDropDownState createState() => _MyMultiDropDownState();
}

class _MyMultiDropDownState extends State<MyMultiDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MultiSelectDialogField<dynamic>(
        title: Text(widget.title),
        items: widget.items.map((e) => MultiSelectItem(e, e)).toList(),
        listType: MultiSelectListType.CHIP,
        selectedColor: AppColors.primaryColor,
        buttonIcon: const Icon(Icons.keyboard_arrow_down),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        selectedItemsTextStyle: const TextStyle(color: Colors.white),
        itemsTextStyle: TextStyle(color: AppColors.primaryColor),
        onConfirm: (value) => widget.onSelected(value),
      ),
    );
  }
}
