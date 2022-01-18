import 'dart:math';

import '../lib_exp.dart';

class CategoryCtrl with ChangeNotifier {
  List<Products> products = [
    // Products(
    //   names: ['Cake'],
    //   price: 1000,
    // ),
    // Products(
    //   names: ['Bread'],
    //   price: 800,
    // ),
    // Products(
    //   names: ['Ice Cream'],
    //   price: 200,
    // ),
    // Products(
    //   names: ['ပလာတာ'],
    //   price: 500,
    // ),
    // Products(
    //   names: ['ထပ်တရာ'],
    //   price: 500,
    // ),
    // Products(
    //   names: ['သကြားပလာတာ'],
    //   price: 500,
    // ),
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
