import 'package:toko_sepatu_heels_wanita/features/carts/domain/repositories/cart_repository.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/data/models/product_model.dart';

class CartRepositoryImpl implements CartRepository {
  final Map<int, int> _items = {}; // productId : qty
  final Map<int, ProductModel> _products = {};

  @override
  List<ProductModel> getCartItems() {
    return _products.values.toList();
  }

  @override
  void addItem(ProductModel product) {
    _products[product.id] = product;
    _items[product.id] = (_items[product.id] ?? 0) + 1;
  }

  @override
  void decreaseItem(int productId) {
    if (_items.containsKey(productId)) {
      _items[productId] = _items[productId]! - 1;

      if (_items[productId]! <= 0) {
        _items.remove(productId);
        _products.remove(productId);
      }
    }
  }

  @override
  int getQuantity(int productId) {
    return _items[productId] ?? 0;
  }

  @override
  bool isItemInCart(int productId) {
    return _items.containsKey(productId);
  }

  @override
  void removeAllItems() {
    _items.clear();
    _products.clear();
  }

  @override
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