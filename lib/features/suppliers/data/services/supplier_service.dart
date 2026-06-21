import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/supplier_model.dart';
import '../../../../core/storage/token_storage.dart';

class SupplierService {
  final String baseUrl = "https://test-ru6s.onrender.com";

  Future<Map<String, String>> _headers() async {
    final token = await TokenStorage.getToken();

    return {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
  }

  Future<List<Supplier>> getSuppliers() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/providers"),
      headers: await _headers(),
    );

    final List data = jsonDecode(res.body);
    return data.map((e) => Supplier.fromJson(e)).toList();
  }

  Future<bool> createSupplier(Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse("$baseUrl/api/v1/providers"),
      headers: await _headers(),
      body: jsonEncode(body),
    );

    return res.statusCode == 200 || res.statusCode == 201;
  }
}