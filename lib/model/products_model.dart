import 'package:stmledger/lib_exp.dart';

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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        date: json[dateConst],
        name: json[productNameConst],
        price: json[productPriceConst],
        qty: json[qtyConst],
        charge: json[chargeConst],
        note: json[noteConst],
        imgURl: json[imgUrlConst],
      );

  Map<String, dynamic> toJson() => {
        dateConst: date,
        productNameConst: name,
        productPriceConst: price,
        qtyConst: qty,
        chargeConst: charge,
        noteConst: note,
        imgUrlConst: imgURl,
      };
}
