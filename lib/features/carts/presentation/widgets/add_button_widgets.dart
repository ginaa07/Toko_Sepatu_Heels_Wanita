import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_sepatu_heels_wanita/features/carts/presentation/providers/cart_provider.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/data/models/product_model.dart';

class AddButtonWidget extends StatelessWidget {
  final ProductModel product;
  const AddButtonWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final isInCart = context.select<CartProvider, bool>(
      (provider) => provider.isInCart(product.id),
    );

    return Center(
      child: Container(
        width: 140, 
        height: 45,
        decoration: BoxDecoration(
          color: Colors.pink.shade100,
          borderRadius: BorderRadius.circular(25),
        ),
        child: isInCart
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center, // 👈 ini penting
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 18),
                    onPressed: () =>
                        context.read<CartProvider>().decreaseItem(product.id),
                  ),
                  Text(
                    context
                        .watch<CartProvider>()
                        .getQuantity(product.id)
                        .toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: () =>
                        context.read<CartProvider>().addItem(product),
                  ),
                ],
              )
            : TextButton(
                onPressed: () => context.read<CartProvider>().addItem(product),
                child: const Text(
                  'Tambah',
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
