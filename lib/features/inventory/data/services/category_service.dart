import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';
import '../../../../core/storage/token_storage.dart';

class CategoryService {
  final String baseUrl = "https://test-ru6s.onrender.com";


  Future<Map<String, String>> _headers() async {
    final token = await TokenStorage.getToken();

    return {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }


  Future<List<Category>> getCategories() async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/api/v1/categories"),
        headers: await _headers(),
      );

      if (res.statusCode != 200) {
        throw Exception("Error al obtener categorías");
      }

      final List data = jsonDecode(res.body);
      return data.map((e) => Category.fromJson(e)).toList();
    } catch (e) {
      throw Exception("getCategories failed: $e");
    }
  }


  Future<Category?> createCategory(String name, String description) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/api/v1/categories"),
        headers: await _headers(),
        body: jsonEncode({
          "name": name,
          "description": description,
        }),
      );

      if (res.statusCode != 201 && res.statusCode != 200) {
        throw Exception("Error al crear categoría");
      }

      final data = jsonDecode(res.body);
      return Category.fromJson(data);
    } catch (e) {
      throw Exception("createCategory failed: $e");
    }
  }


  Future<Category?> getCategoryById(int id) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/api/v1/categories/$id"),
        headers: await _headers(),
      );

      if (res.statusCode != 200) return null;

      return Category.fromJson(jsonDecode(res.body));
    } catch (_) {
      return null;
    }
  }
}