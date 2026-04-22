import 'package:toko_sepatu_heels_wanita/core/constants/api_constants.dart';
import 'package:toko_sepatu_heels_wanita/core/services/dio_client.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/data/models/product_model.dart';
import 'package:toko_sepatu_heels_wanita/features/dashboard/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<ProductModel>> getProducts({
    int page = 1,
    int limit = 10,
    String? category,
  }) async {
    final response = await DioClient.instance.get(
      ApiConstants.products,
      queryParameters: {'page': page, 'limit': limit, 'category': category},
    );

    final List<dynamic> data = response.data['data'];
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final response = await DioClient.instance.get(
      '${ApiConstants.products}/$id',
    );
    return ProductModel.fromJson(response.data['data']);
  }
}
