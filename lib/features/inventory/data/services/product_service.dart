import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';
import '../../../../core/storage/token_storage.dart';

class ProductService {
  static const baseUrl = "https://test-ru6s.onrender.com";

  Future<List<Product>> getProducts() async {
    final token = await TokenStorage.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/api/v1/products"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    final List data = jsonDecode(response.body);

    return data.map((e) => Product.fromJson(e)).toList();
  }
}