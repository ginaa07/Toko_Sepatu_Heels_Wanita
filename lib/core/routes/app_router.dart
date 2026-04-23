import 'package:flutter/material.dart';
import 'package:toko_sepatu_heels_wanita/core/services/secure_storage.dart';
import 'package:toko_sepatu_heels_wanita/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:toko_sepatu_heels_wanita/features/auth/data/domain/presentation/pages/login_page.dart';
import 'package:toko_sepatu_heels_wanita/features/auth/data/domain/presentation/pages/register_page.dart';
import 'package:toko_sepatu_heels_wanita/features/auth/data/domain/presentation/pages/verify_email_page.dart';
import 'package:toko_sepatu_heels_wanita/features/auth/data/domain/presentation/providers/auth_provider.dart';
import 'package:toko_sepatu_heels_wanita/features/carts/presentation/pages/cart_page.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/presentation/providers/product_provider.dart';

class AppRouter { 
  static const String splash      = '/'; 
  static const String login       = '/login'; 
  static const String register    = '/register'; 
  static const String verifyEmail = '/verify-email'; 
  static const String dashboard   = '/dashboard'; 
  static const String cart        = '/cart';
 
  static Map<String, WidgetBuilder> get routes => { 
    splash:      (_) => const SplashPage(), 
    login:       (_) => const LoginPage(), 
    register:    (_) => const RegisterPage(), 
    verifyEmail: (_) => const VerifyEmailPage(), 
    dashboard:   (_) => const AuthGuard(child: DashboardPage()), 
    cart:        (_) => const CartPage(),
  }; 
}

// Bungkus halaman yang butuh autentikasi dengan AuthGuard
class AuthGuard extends StatelessWidget {
  final Widget child;
  const AuthGuard({super.key, required this.child});


  @override
  Widget build(BuildContext context) {
    final status = context.watch<AuthProvider>().status;


    return switch (status) {
      AuthStatus.authenticated => child,           // Lanjut ke halaman
      AuthStatus.emailNotVerified =>
        const VerifyEmailPage(),                   // Redirect verifikasi
      _ => const LoginPage(),                     // Redirect login
    };
  }

}
 class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),

      ],
      child: MaterialApp(
        title:                  'My App',
        debugShowCheckedModeBanner: false,
        theme:                  AppTheme.light,
        initialRoute:           AppRouter.splash,
        routes:                 AppRouter.routes,
      ),
    );
  }
}


// SplashPage: cek token tersimpan, redirect otomatis
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override State<SplashPage> createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }


  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2)); // Animasi splash
    if (!mounted) return;


    final token = await SecureStorageService.getToken();
    final route = token != null ? AppRouter.dashboard : AppRouter.login;
    Navigator.pushReplacementNamed(context, route);
  }


  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}




// Penggunaan di routes:
// dashboard: (_) => const AuthGuard(child: DashboardPage())
//            ↑ DashboardPage HANYA muncul jika status = authenticated