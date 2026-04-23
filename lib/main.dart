import 'package:firebase_core/firebase_core.dart';
import 'package:toko_sepatu_heels_wanita/core/routes/app_router.dart';
import 'package:toko_sepatu_heels_wanita/features/auth/data/domain/presentation/providers/auth_provider.dart';
import 'package:toko_sepatu_heels_wanita/features/carts/presentation/providers/cart_provider.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/presentation/providers/product_provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_sepatu_heels_wanita/features/carts/data/domain/repositories/cart_repository_impl.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider(repository: CartRepositoryImpl()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Sepatu Heels Wanita',
      initialRoute: AppRouter.splash,
      routes: AppRouter.routes,
    );
  }
}
