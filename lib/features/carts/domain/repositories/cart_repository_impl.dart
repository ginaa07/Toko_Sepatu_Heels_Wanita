import 'package:toko_sepatu_heels_wanita/features/carts/domain/repositories/cart_repository.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/data/models/product_model.dart';

class CartRepositoryImpl implements CartRepository {
  // Kita gunakan _items (private) agar data lebih aman sesuai standar OOP
  final List<ProductModel> _items = [];

  @override
  List<ProductModel> getCartItems() => List.unmodifiable(_items);

  @override
  void addItem(ProductModel product) => _items.add(product);

  @override
  void removeAllItems() => _items.clear();
  
  @override
  bool isItemInCart(int productId) => _items.any((p) => p.id == productId);
}
