import 'package:stmledger/lib_exp.dart';

class VoucherModel {
  int? id;
  String? iso8601Date;
  int? charge;
  String? note;
  List<Product>? products;
  VoucherModel(
      {this.id, this.products, this.charge, this.iso8601Date, this.note});

  static VoucherModel clone(VoucherModel v) => VoucherModel(
        id: v.id,
        iso8601Date: v.iso8601Date,
        charge: v.charge,
        note: v.note,
        products: v.products,
      );

  factory VoucherModel.fromJson(Map<String, dynamic> json) => VoucherModel(
        id: json[uniqueIdConst],
        iso8601Date: json[dateConst],
        charge: json[chargeConst],
        note: json[noteConst],
        products: (jsonDecode(json[productsConst]) as List)
            .map((e) => Product.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        uniqueIdConst: id,
        dateConst: iso8601Date,
        chargeConst: charge,
        noteConst: note,
        productsConst: products,
      };
}
