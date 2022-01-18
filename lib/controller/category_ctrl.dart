import 'dart:math';

import '../lib_exp.dart';

class CategoryCtrl with ChangeNotifier {
  List<Products> products = [
    Products(
      name: 'Cake',
      price: 1000,
      imgURl: 'assets/icons/bakery.png',
      qty: 0,
    ),
    Products(
      name: 'Bread',
      price: 800,
      imgURl: 'assets/icons/bread1.png',
      qty: 0,
    ),
    Products(
      name: 'Ice Cream',
      price: 200,
      imgURl: 'assets/icons/bread2.png',
      qty: 0,
    ),
    Products(
      name: 'ပလာတာ',
      price: 500,
      imgURl: 'assets/icons/bread3.png',
      qty: 0,
    ),
    Products(
      name: 'ထပ်တရာ',
      price: 500,
      imgURl: 'assets/icons/bread4.png',
      qty: 0,
    ),
    Products(
      name: 'သကြားပလာတာ',
      price: 500,
      imgURl: 'assets/icons/bread4.png',
      qty: 0,
    ),
  ];

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
