import '../../lib_exp.dart';

class MyDatePicker extends StatefulWidget {
  final ValueChanged<DateTime?> onSelectedDateTime;
  const MyDatePicker({
    required this.onSelectedDateTime,
    Key? key,
  }) : super(key: key);

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime? date = DateTime.now();

  Future<void> _pickDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: date!,
      firstDate: DateTime(2022),
      lastDate: date!,
      builder: (_, child) => SizedBox(child: child),
    );
    if (selectedDate != null) {
      setState(() => date = selectedDate);
      widget.onSelectedDateTime(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: _pickDate,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          date!.ddMMyyyy,
          style: const TextStyle(
            fontSize: 12,
          ),
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
