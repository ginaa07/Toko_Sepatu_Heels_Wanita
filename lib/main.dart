import 'package:firebase_core/firebase_core.dart';
import 'package:toko_sepatu_heels_wanita/core/routes/app_router.dart';
import 'package:toko_sepatu_heels_wanita/features/auth/data/domain/presentation/providers/auth_provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
