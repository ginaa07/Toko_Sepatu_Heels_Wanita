import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toko_sepatu_heels_wanita/core/constants/api_constants.dart';
import 'package:toko_sepatu_heels_wanita/core/services/dio_client.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/data/models/product_model.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductProvider extends ChangeNotifier {
  ProductStatus _status = ProductStatus.initial;
  List<ProductModel> _products = [];
  String? _error;

  ProductStatus get status => _status;
  List<ProductModel> get products => _products;
  String? get error => _error;
  bool get isLoading => _status == ProductStatus.loading;

  Future<void> fetchProducts() async {
    _status = ProductStatus.loading;
    notifyListeners();

    try {
      final response = await DioClient.instance.get(ApiConstants.products);

      // 🔍 DEBUG RESPONSE
      print("=== RESPONSE PRODUCTS ===");
      print(response.data);
      print("TYPE: ${response.data.runtimeType}");

      // ✅ Validasi response
      if (response.data == null) {
        throw Exception("Response kosong");
      }

      if (response.data['data'] == null) {
        throw Exception("Key 'data' tidak ditemukan di response");
      }

      final List<dynamic> data = response.data['data'];

      // ✅ Mapping ke model
      _products = data.map((e) {
        try {
          return ProductModel.fromJson(e);
        } catch (err) {
          print("ERROR PARSE PRODUCT: $err");
          throw Exception("Gagal parsing product");
        }
      }).toList();

      print("JUMLAH PRODUK: ${_products.length}");

      _status = ProductStatus.loaded;
    } catch (e) {
      print("=== ERROR FETCH PRODUCTS ===");
      print(e);

      _error = 'Gagal memuat produk';
      _status = ProductStatus.error;
    }

    notifyListeners();
  }
}