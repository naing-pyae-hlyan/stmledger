import '../lib_exp.dart';

class SaleCtrl with ChangeNotifier {
  VoucherModel voucher = VoucherModel(
    products: [],
  );
  void initCart(List<Product> l) {
    for (var p in l) {
      p.qty = 0;
    }
    voucher = VoucherModel(
      iso8601Date: MyDateUtils.iso8601Date,
      charge: 0,
      note: '',
      products: l,
    );
  }

  int count = 1;

  void addQty(int index) {
    if (voucher.products!.isEmpty || voucher.products!.length < index) return;
    voucher.products![index].qty = voucher.products![index].qty! + count;
    notifyListeners();
  }

  void removeQty(int index) {
    if (voucher.products!.isEmpty || voucher.products!.length < index) return;
    if (voucher.products![index].qty! < 1) return;

    voucher.products![index].qty = voucher.products![index].qty! - count;
    notifyListeners();
  }

  int get cartCounter {
    int count = 0;
    for (var p in voucher.products!) {
      if (p.qty != null && p.qty! > 0) {
        count += p.qty!;
      }
    }
    return count;
  }

  VoucherModel get getConfirmedVoucher {
    List<Product> l = [];
    for (var p in voucher.products!) {
      if (p.qty != null && p.price != null && p.qty! > 0 && p.price! > 0) {
        l.add(p);
      }
    }
    return VoucherModel(
      iso8601Date: voucher.iso8601Date,
      charge: voucher.charge,
      note: voucher.note,
      products: l,
    );
  }

  int get totalAmount {
    int amt = 0;
    for (var p in voucher.products!) {
      if (p.price != null && p.qty != null && p.price! > 0 && p.qty! > 0) {
        amt += (p.price! * p.qty!);
      }
    }
    return amt;
  }
}
