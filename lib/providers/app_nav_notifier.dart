import 'package:flutter/material.dart';

class AppNavNotifier extends ChangeNotifier {
  final List<Product> _cart = [];

  int _currentTabIndex = 0;

  int get currentTabIndex => _currentTabIndex;

  setCurrentTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  List<Product> get cart => _cart;

  void addProduct(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}

class Product {
  final String id;
  final String title;
  final String description;
  final double price;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price});
}
