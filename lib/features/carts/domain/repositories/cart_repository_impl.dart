import 'package:toko_sepatu_heels_wanita/features/carts/domain/repositories/cart_repository.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/data/models/product_model.dart';

class CartRepositoryImpl implements CartRepository {
  final Map<ProductModel, int> _items = {};

  @override
  List<ProductModel> getCartItems() => _items.keys.toList();

  int getQuantity(int productId) {
    return _items.entries
        .firstWhere((e) => e.key.id == productId, orElse: () => MapEntry(ProductModel.empty(), 0))
        .value;
  }

  @override
  void addItem(ProductModel product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
    }
  }

  void decreaseItem(int productId) {
    final entry = _items.entries.firstWhere(
      (e) => e.key.id == productId,
      orElse: () => throw Exception("Item tidak ditemukan"),
    );

    if (entry.value > 1) {
      _items[entry.key] = entry.value - 1;
    } else {
      _items.remove(entry.key);
    }
  }

  @override
  void removeAllItems() => _items.clear();

  @override
  bool isItemInCart(int productId) =>
      _items.keys.any((p) => p.id == productId);
}