

enum ProductStatus { initial, loading, loaded, error } 
 
class ProductProvider extends ChangeNotifier { 
  ProductStatus       _status   = ProductStatus.initial; 
  List<ProductModel>  _products = []; 
  String?             _error; 
 
 ProductStatus      get status   => _status; 
  List<ProductModel> get products => _products; 
  String?            get error    => _error; 
    bool               get isLoading => _status == ProductStatus.loading; 
 
  Future<void> fetchProducts() async { 
    _status = ProductStatus.loading; 
    notifyListeners(); 
 
    try { 