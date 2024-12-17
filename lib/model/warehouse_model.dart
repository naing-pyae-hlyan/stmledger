import 'package:stmledger/lib_exp.dart';

class WarehouseModel {
  int? id;
  int? productId;
  String? iso8601Date;
  String? productName;
  int? inStock;
  int? outStock;
  WarehouseModel({
    this.id,
    required this.productId,
    this.iso8601Date,
    this.productName,
    this.inStock = 0,
    this.outStock = 0,
  });

  factory WarehouseModel.fromJson(Map<String, dynamic> json) => WarehouseModel(
        id: json[uniqueIdConst],
        productId: json[productIdConst],
        iso8601Date: json[dateConst],
        productName: json[productNameConst],
        inStock: json[inStockConst],
        outStock: json[outStockConst],
      );

  Map<String, dynamic> toJson() => {
        uniqueIdConst: id,
        productIdConst: productId,
        dateConst: iso8601Date,
        productNameConst: productName,
        inStockConst: inStock,
        outStockConst: outStock,
      };
}
