import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/token_storage.dart';

class DashboardService {
  static const String baseUrl = "https://test-ru6s.onrender.com";

  Future<Map<String, dynamic>> getDashboard() async {
    final token = await TokenStorage.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/api/v1/dashboard"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    return jsonDecode(response.body);
  }
}