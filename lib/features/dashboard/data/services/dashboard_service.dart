import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/storage/token_storage.dart';

class DashboardService {
  final String baseUrl = "https://test-ru6s.onrender.com";

  Future<Map<String, String>> _headers() async {
    final token = await TokenStorage.getToken();

    return {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
  }

  Future<int> getProductsCount() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/products"),
      headers: await _headers(),
    );

    final data = jsonDecode(res.body);
    return data.length;
  }


  Future<int> getLowStockCount() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/products"),
      headers: await _headers(),
    );

    final data = jsonDecode(res.body);

    return data.where((p) => p["minStock"] >= (p["stock"] ?? 0)).length;
  }

  Future<double> getMonthlyIncome() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/kits"),
      headers: await _headers(),
    );

    final data = jsonDecode(res.body);

    double total = 0;
    for (var k in data) {
      total += (k["totalPrice"] ?? 0).toDouble();
    }

    return total;
  }


  Future<List<Map<String, dynamic>>> getTopProducts() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/products"),
      headers: await _headers(),
    );

    final data = jsonDecode(res.body);

    return data.map<Map<String, dynamic>>((p) {
      return {
        "name": p["name"],
        "value": p["unitPrice"] ?? 0,
      };
    }).toList();
  }


  Future<List<Map<String, dynamic>>> getAlerts() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/products"),
      headers: await _headers(),
    );

    final data = jsonDecode(res.body);

    return data
        .where((p) => (p["stock"] ?? 0) <= (p["minStock"] ?? 0))
        .map<Map<String, dynamic>>((p) {
      return {
        "title": "Producto a agotarse",
        "message": "${p["name"]} está por vencer stock",
      };
    }).toList();
  }
}