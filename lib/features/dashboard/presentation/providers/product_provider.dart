

enum ProductStatus { initial, loading, loaded, error } 
 
class ProductProvider extends ChangeNotifier { 
  ProductStatus       _status   = ProductStatus.initial; 
  List<ProductModel>  _products = []; 
  String?             _error; 
 