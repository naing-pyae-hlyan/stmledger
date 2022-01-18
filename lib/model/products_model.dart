class Products {
  int? no;
  DateTime? date;
  List<String>? names;
  int? price;
  int? qty;
  int? charge;
  String? note;
  String? imgURl;

  Products({
    this.no,
    this.date,
    this.names,
    this.price = 0,
    this.qty = 0,
    this.charge = 0,
    this.note,
    this.imgURl = '',
  });
}
