import '../lib_exp.dart';

class SaleCtrl with ChangeNotifier {
  List<Products> cartList = [];
  void initCart(List<Products> l) {
    cartList = l;
  }

  void addQty(int index) {
    if (cartList.isEmpty || cartList.length < index) return;
    cartList[index].qty = cartList[index].qty! + 1;
    notifyListeners();
  }

  void removeQty(int index) {
    if (cartList.isEmpty || cartList.length < index) return;
    if (cartList[index].qty! < 1) return;

    cartList[index].qty = cartList[index].qty! - 1;
    notifyListeners();
  }

  int get cartCounter {
    int count = 0;
    for (var p in cartList) {
      if (p.qty != null && p.qty! > 0) {
        count += p.qty!;
      }
    }
    return count;
  }

  int get totalAmount {
    int amt = 0;
    for (var p in cartList) {
      if (p.price != null && p.qty != null && p.price! > 0 && p.qty! > 0) {
        amt += (p.price! * p.qty!);
      }
    }
    return amt;
  }
}
