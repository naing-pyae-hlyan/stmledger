import '../lib_exp.dart';

class CategoryCtrl with ChangeNotifier {
  List<Product> products = [
    // Product(
    //   name: 'Cake',
    //   price: 1000,
    //   imgURl: 'assets/icons/bakery.png',
    //   qty: 0,
    // ),
    // Product(
    //   name: 'Bread',
    //   price: 800,
    //   imgURl: 'assets/icons/bread1.png',
    //   qty: 0,
    // ),
    // Product(
    //   name: 'Ice Cream',
    //   price: 200,
    //   imgURl: 'assets/icons/bread2.png',
    //   qty: 0,
    // ),
    // Product(
    //   name: 'ပလာတာ',
    //   price: 500,
    //   imgURl: 'assets/icons/bread3.png',
    //   qty: 0,
    // ),
    // Product(
    //   name: 'ထပ်တရာ',
    //   price: 500,
    //   imgURl: 'assets/icons/bread4.png',
    //   qty: 0,
    // ),
    // Product(
    //   name: 'သကြားပလာတာ',
    //   price: 500,
    //   imgURl: 'assets/icons/bread4.png',
    //   qty: 0,
    // ),
  ];

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
