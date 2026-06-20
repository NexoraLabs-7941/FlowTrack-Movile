import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kit_model.dart';
import '../../../../core/storage/token_storage.dart';

class KitService {
  final baseUrl = "https://test-ru6s.onrender.com";

  Future<List<Kit>> getKits() async {
    final token = await TokenStorage.getToken();

    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/kits"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    final data = jsonDecode(res.body);
    return (data as List).map((e) => Kit.fromJson(e)).toList();
  }

  Future<void> createKit(Map<String, dynamic> body) async {
    final token = await TokenStorage.getToken();

    await http.post(
      Uri.parse("$baseUrl/api/v1/kits"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
  }
}