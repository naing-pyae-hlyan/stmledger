import '../../lib_exp.dart';

class MyDropDown extends StatefulWidget {
  final List<String> list;
  final ValueChanged<String> onChanged;
  final bool needAllLabel;
  final BorderStyle? borderStyle;
  const MyDropDown({
    Key? key,
    this.needAllLabel = true,
    required this.list,
    required this.onChanged,
    this.borderStyle,
  }) : super(key: key);

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  late String _selectedName;

  @override
  void initState() {
    super.initState();
    if (widget.needAllLabel) {
      _selectedName = allCategoryConst;
    } else {
      _selectedName = widget.list[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          style: widget.borderStyle ?? BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<String>(
        value: _selectedName,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor:
            widget.borderStyle == null ? Colors.white : AppColors.primaryColor,
        items: widget.list
            .map(
              (String value) => DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color: widget.borderStyle == null
                        ? AppColors.primaryColor
                        : Colors.white,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (dynamic v) {
          widget.onChanged(v);
          setState(() => _selectedName = v);
        },
      ),
    );
  }
}
