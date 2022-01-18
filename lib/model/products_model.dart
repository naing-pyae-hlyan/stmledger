class Product {
  int? no;
  DateTime? date;
  String? name;
  int? price;
  int? qty;
  int? charge;
  String? note;
  String? imgURl;

  Product({
    this.no,
    this.date,
    this.name,
    this.price = 0,
    this.qty = 0,
    this.charge = 0,
    this.note,
    this.imgURl = '',
  });
}
