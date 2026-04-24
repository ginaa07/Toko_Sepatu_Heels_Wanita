import 'package:toko_sepatu_heels_wanita/features/dashboard/data/models/product_model.dart';

class CartRepository {
  final Map<int, int> _items = {}; // productId : qty
  final Map<int, ProductModel> _products = {};

  List<ProductModel> getCartItems() {
    return _products.values.toList();
  }

  void addItem(ProductModel product) {
    _products[product.id] = product;
    _items[product.id] = (_items[product.id] ?? 0) + 1;
  }

  void decreaseItem(int productId) {
    if (_items.containsKey(productId)) {
      _items[productId] = _items[productId]! - 1;

      if (_items[productId]! <= 0) {
        _items.remove(productId);
        _products.remove(productId);
      }
    }
  }

  int getQuantity(int productId) {
    return _items[productId] ?? 0;
  }

  bool isItemInCart(int productId) {
    return _items.containsKey(productId);
  }

  void removeAllItems() {
    _items.clear();
    _products.clear();
  }

  double getTotalPrice() {
    double total = 0;
    _items.forEach((id, qty) {
      final product = _products[id];
      if (product != null) {
        total += product.price * qty;
      }
    });
    return total;
  }
}