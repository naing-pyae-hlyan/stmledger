import 'package:stmledger/lib_exp.dart';

class Product {
  int? id;
  String? name;
  int? price;
  int? qty;
  String? imgURl;
  int? limit;
  String? limitLabel;

  Product({
    this.id,
    this.name,
    this.price = 0,
    this.qty = 0,
    this.imgURl = '',
    this.limit = 0,
    this.limitLabel,
  });

  static Product clone(Product p) => Product(
        id: p.id,
        name: p.name,
        price: p.price,
        qty: p.qty,
        imgURl: p.imgURl,
        limit: p.limit,
      );

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
