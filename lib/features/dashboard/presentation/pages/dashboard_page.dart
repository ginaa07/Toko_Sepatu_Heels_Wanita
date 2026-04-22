import 'package:flutter/material.dart';
import 'package:toko_sepatu_heels_wanita/core/routes/app_router.dart';
import 'package:toko_sepatu_heels_wanita/features/auth/data/domain/presentation/providers/auth_provider.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/presentation/providers/product_provider.dart';

class DashboardPage extends StatefulWidget { 
  const DashboardPage({super.key}); 
  @override 
  State<DashboardPage> createState() => _DashboardPageState(); 
} 
 
class _DashboardPageState extends State<DashboardPage> { 
  @override 
  void initState() { 
    super.initState(); 
    // Fetch produk begitu halaman dibuka 
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      context.read<ProductProvider>().fetchProducts(); 
    }); 
  }

   @override 
  Widget build(BuildContext context) { 
    final auth    = context.watch<AuthProvider>(); 
    final product = context.watch<ProductProvider>(); 
 
    return Scaffold( 
      appBar: AppBar( 
        title: Column( 
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [ 
            const Text('Dashboard', style: TextStyle(fontSize: 18)), 
            Text( 
              'Halo, ${auth.firebaseUser?.displayName ?? 'User'}!', 
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal), 
            ), 
          ], 
        ), 
         actions: [ 
          IconButton( 
            icon: const Icon(Icons.logout), 
            onPressed: () async { 
              await auth.logout(); 
              if (!mounted) return; 
              Navigator.pushReplacementNamed(context, AppRouter.login); 
            }, 
          ),
           ], 
      ), 
 
      body: switch (product.status) { 
        ProductStatus.loading || ProductStatus.initial => const Center( 
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [ 
                CircularProgressIndicator(), 
                SizedBox(height: 16), 
                Text('Memuat produk...'), 
              ], 
            ), 
          ),

          ProductStatus.error => Center( 
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [ 
                const Icon(Icons.error_outline, size: 64, color: Colors.red), 
                const SizedBox(height: 16), 
                Text(product.error ?? 'Terjadi kesalahan'), 
                const SizedBox(height: 16), 
                ElevatedButton.icon( 
                  icon: const Icon(Icons.refresh), 
                  label: const Text('Coba Lagi'), 
                  onPressed: () => product.fetchProducts(), 
                ), 
              ], 
            ), 
          ), 