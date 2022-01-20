import '../../lib_exp.dart';

class MyDropDownModel {
  final String? value;
  final dynamic key;
  MyDropDownModel({this.value, this.key});
}

class MyDropDown extends StatefulWidget {
  final MyDropDownModel selectedName;
  final List<MyDropDownModel> list;
  final ValueChanged<MyDropDownModel> onChanged;
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
      child: DropdownButton<MyDropDownModel>(
        value: widget.selectedName,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: Colors.white,
        items: widget.list
            .map(
              (MyDropDownModel model) => DropdownMenuItem(
                value: model,
                child: Text(model.value!),
              ),
            )
            .toList(),
        onChanged: (dynamic v) => widget.onChanged(v),
      ),
    );
  }
}
