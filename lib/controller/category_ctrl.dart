import '../lib_exp.dart';

class CategoryCtrl with ChangeNotifier {
  List<Products> products = [];

  void addProducts(Products p) {
    products.add(p);
    notifyListeners();
  }

  void updateProducts(int index, Products p) {
    products[index] = p;
    notifyListeners();
  }

  void removeProducts(int index) {
    products.removeAt(index);
    notifyListeners();
  }
}
