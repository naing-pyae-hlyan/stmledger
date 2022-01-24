import 'package:stmledger/lib_exp.dart';

class Product {
  int? id;
  String? name;
  int? price;
  int? qty;
  String? imgURl;

  Product({
    this.id,
    this.name,
    this.price = 0,
    this.qty = 0,
    this.imgURl = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json[uniqueIdConst],
        name: json[productNameConst],
        price: json[productPriceConst],
        qty: json[qtyConst],
        imgURl: json[imgUrlConst],
      );

  Map<String, dynamic> toJson() => {
        productNameConst: name,
        productPriceConst: price,
        qtyConst: qty,
        imgUrlConst: imgURl,
      };
}
