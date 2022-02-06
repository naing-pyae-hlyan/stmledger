import 'package:stmledger/lib_exp.dart';

class WarehouseModel {
  int? id;
  String? iso8601Date;
  String? productName;
  int? inStock;
  int? outStock;
  WarehouseModel({
    this.id,
    this.iso8601Date,
    this.productName,
    this.inStock = 0,
    this.outStock = 0,
  });

  factory WarehouseModel.fromJson(Map<String, dynamic> json) => WarehouseModel(
        id: json[uniqueIdConst],
        iso8601Date: json[dateConst],
        productName: json[productNameConst],
        inStock: json[inStockConst],
        outStock: json[outStockConst],
      );

  Map<String, dynamic> toJson() => {
        uniqueIdConst: id,
        dateConst: iso8601Date,
        productNameConst: productName,
        inStockConst: inStock,
        outStockConst: outStock,
      };
}
