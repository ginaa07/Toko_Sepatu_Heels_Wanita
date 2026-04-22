import 'package:flutter/material.dart';

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