import 'package:internship_assignment/models/product_model.dart';
import 'package:internship_assignment/respositories/product_api_service.dart';

class ProductRepository {
  final ProductApiService apiService;

  ProductRepository(this.apiService);

  Future<List<Product>> getProducts() {
    return apiService.fetchProducts();
  }
}
