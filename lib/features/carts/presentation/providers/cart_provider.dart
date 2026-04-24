import 'package:flutter/material.dart';
import 'package:toko_sepatu_heels_wanita/features/carts/domain/repositories/cart_repository.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository _repository;

  CartProvider({required CartRepository repository}) : _repository = repository;

  List<ProductModel> get items => _repository.getCartItems();

  void addItem(ProductModel product) {
    _repository.addItem(product);
    notifyListeners();
  }

  void decreaseItem(int productId) {
    _repository.decreaseItem(productId);
    notifyListeners();
  }

  int getQuantity(int productId) {
    return _repository.getQuantity(productId);
  }

  double get totalPrice {
    return _repository.getTotalPrice();
  }

  void removeAll() {
    _repository.removeAllItems();
    notifyListeners();
  }

  bool isInCart(int productId) => _repository.isItemInCart(productId);
}
