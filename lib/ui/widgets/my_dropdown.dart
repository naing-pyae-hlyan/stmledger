import '../../lib_exp.dart';

class MyDropDown extends StatefulWidget {
  final List<String> list;
  final ValueChanged<String> onChanged;
  const MyDropDown({
    Key? key,
    required this.list,
    required this.onChanged,
  }) : super(key: key);

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String _selectedName = allCategoryConst;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<String>(
        value: _selectedName,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: Colors.white,
        items: widget.list
            .map(
              (String value) => DropdownMenuItem(
                value: value,
                child: Text(value),
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
