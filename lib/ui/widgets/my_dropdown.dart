import '../../lib_exp.dart';

class MyDropDown extends StatefulWidget {
  final String selectedName;
  final List<String> list;
  final ValueChanged<dynamic> onChanged;
  const MyDropDown({
    Key? key,
    required this.selectedName,
    required this.list,
    required this.onChanged,
  }) : super(key: key);

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<String>(
        value: widget.selectedName,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: Colors.white,
        items: widget.list
            .map(
              (String name) => DropdownMenuItem(
                value: name,
                child: Text(name),
              ),
            )
            .toList(),
        onChanged: widget.onChanged,
      ),
    );
  }
}
