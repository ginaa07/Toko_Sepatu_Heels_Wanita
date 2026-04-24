import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_sepatu_heels_wanita/features/carts/presentation/providers/cart_provider.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/data/models/product_model.dart';

class AddButtonWidget extends StatelessWidget {
  final ProductModel product;
  const AddButtonWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final qty = cart.getQuantity(product.id);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: qty == 0
          ? TextButton(
              onPressed: () {
                cart.addItem(product);
              },
              child: const Text(
                'TAMBAH',
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )

          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 18),
                  onPressed: () => cart.decreaseItem(product.id),
                ),
                Text(
                  qty.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: () => cart.addItem(product),
                ),
              ],
            ),
    );
  }
}