import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internship_assignment/models/product_model.dart';

class ProductApiService {
  static const String apiUrl = "https://jsonplaceholder.typicode.com/photos";

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> productJson = json.decode(response.body);
        return productJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load products: $e");
    }
  }
}

