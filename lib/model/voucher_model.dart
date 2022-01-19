import 'package:stmledger/lib_exp.dart';

class VoucherModel {
  int? id;
  String? voucher;
  int? charge;
  int? timestamp;
  String? note;
  VoucherModel({this.id, this.voucher, this.charge, this.timestamp, this.note});

  factory VoucherModel.fromJson(Map<String, dynamic> json) => VoucherModel(
        id: json[uniqueIdConst],
        timestamp: json[timestampConst],
        charge: json[chargeConst],
        note: json[noteConst],
        voucher: json[voucherConst],
      );

  Map<String, dynamic> toJson() => {
        uniqueIdConst: id,
        timestampConst: timestamp,
        chargeConst: charge,
        noteConst: note,
        voucherConst: voucher,
      };
}

class Voucher {
  String? name;
  int? qty;
  int? price;
  Voucher({this.name, this.qty, this.price});

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        name: json[productNameConst],
        qty: json[qtyConst],
        price: json[productPriceConst],
      );
}

List<Product> convertVoucherModelToProduct(VoucherModel v) {
  List<Product> p = [];
  final list = jsonDecode(v.voucher!);
  for (Map<String, dynamic> i in list) {
    p.add(Product(
      id: v.id,
      timestamp: v.timestamp,
      charge: v.charge,
      note: v.note,
      name: i[productNameConst],
      price: i[productPriceConst],
      qty: i[qtyConst],
    ));
  }
  return p;
}
