

class ProductRepositoryImpl implements ProductRepository { 
  @override 
  Future<List<ProductModel>> getProducts({ 
    int page = 1, 
    int limit = 10, 
    String? category, 
  }) async { 
    final response = await DioClient.instance.get( 
      ApiConstants.products, 
      queryParameters: { 
        'page': page, 
        'limit': limit, 