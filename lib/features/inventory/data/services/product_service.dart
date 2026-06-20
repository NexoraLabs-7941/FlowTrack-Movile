import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';
import '../../../../core/storage/token_storage.dart';

class ProductService {
  final String baseUrl = "https://test-ru6s.onrender.com";

  Future<Map<String, String>> _headers() async {
    final token = await TokenStorage.getToken();

    return {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
  }


  Future<List<Product>> getProducts() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/products"),
      headers: await _headers(),
    );

    final List data = jsonDecode(res.body);

    return data.map((e) => Product.fromJson(e)).toList();
  }


  Future<Product> createProduct(Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse("$baseUrl/api/v1/products"),
      headers: await _headers(),
      body: jsonEncode(body),
    );

    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception("Error creando producto: ${res.body}");
    }

    return Product.fromJson(jsonDecode(res.body));
  }
}