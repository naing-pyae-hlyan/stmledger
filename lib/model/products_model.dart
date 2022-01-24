import 'package:stmledger/lib_exp.dart';

class Product {
  int? id;
  // int? timestamp;
  String? name;
  int? price;
  int? qty;
  // int? charge;
  // String? note;
  String? imgURl;

  Product({
    this.id,
    // this.timestamp,
    this.name,
    this.price = 0,
    this.qty = 0,
    // this.charge = 0,
    // this.note,
    this.imgURl = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json[uniqueIdConst],
        // timestamp: json[timestampConst],
        name: json[productNameConst],
        price: json[productPriceConst],
        qty: json[qtyConst],
        // charge: json[chargeConst],
        // note: json[noteConst],
        imgURl: json[imgUrlConst],
      );

  Map<String, dynamic> toJson() => {
        // timestampConst: timestamp,
        productNameConst: name,
        productPriceConst: price,
        qtyConst: qty,
        // chargeConst: charge,
        // noteConst: note,
        imgUrlConst: imgURl,
      };
}
