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
      "Accept": "application/json",
    };
  }

  // 🔥 helper seguro para parsear respuesta
  dynamic _decode(http.Response res) {
    if (res.statusCode != 200) {
      throw Exception("Error ${res.statusCode}: ${res.body}");
    }
    return jsonDecode(res.body);
  }

  // 📦 PRODUCTS COUNT
  Future<int> getProductsCount() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/products"),
      headers: await _headers(),
    );

    final data = _decode(res);

    if (data is List) return data.length;
    return (data["data"] as List).length;
  }

  // ⚠️ LOW STOCK
  Future<int> getLowStockCount() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/products"),
      headers: await _headers(),
    );

    final data = _decode(res);

    final List products =
        data is List ? data : (data["data"] ?? []);

    return products.where((p) {
      final stock = (p["stock"] ?? 0);
      final minStock = (p["minStock"] ?? 0);

      return stock <= minStock;
    }).length;
  }

  // 💰 MONTHLY INCOME (KITS)
  Future<double> getMonthlyIncome() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/kits"),
      headers: await _headers(),
    );

    final data = _decode(res);

    final List kits =
        data is List ? data : (data["data"] ?? []);

    double total = 0;

    for (var k in kits) {
      total += (k["totalPrice"] ?? 0).toDouble();
    }

    return total;
  }

  // 📊 TOP PRODUCTS
  Future<List<Map<String, dynamic>>> getTopProducts() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/products"),
      headers: await _headers(),
    );

    final data = _decode(res);

    final List products =
        data is List ? data : (data["data"] ?? []);

    return products.map<Map<String, dynamic>>((p) {
      return {
        "name": p["name"] ?? "Sin nombre",
        "value": p["unitPrice"] ?? 0,
      };
    }).toList();
  }

  // 🔔 ALERTS
  Future<List<Map<String, dynamic>>> getAlerts() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/products"),
      headers: await _headers(),
    );

    final data = _decode(res);

    final List products =
        data is List ? data : (data["data"] ?? []);

    return products
        .where((p) =>
            (p["stock"] ?? 0) <= (p["minStock"] ?? 0))
        .map<Map<String, dynamic>>((p) {
      return {
        "title": "Producto a agotarse",
        "message": "${p["name"]} está por agotarse",
      };
    }).toList();
  }
}