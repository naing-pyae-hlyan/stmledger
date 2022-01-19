import '../lib_exp.dart';

class CategoryCtrl with ChangeNotifier {
  List<Product> products = [];

  void addProducts(Product p) {
    products.add(p);
    notifyListeners();
  }

  void updateProducts(int index, Product p) {
    products[index] = p;
    notifyListeners();
  }

  void removeProducts(int index) {
    products.removeAt(index);
    notifyListeners();
  }
}
