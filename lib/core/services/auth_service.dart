import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/token_storage.dart';
class AuthService {
  static const String baseUrl = "https://test-ru6s.onrender.com";

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/v1/authentication/sign-in"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (data["token"] != null) {
      await TokenStorage.saveToken(data["token"]);
    }

    return data;
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/v1/authentication/sign-up"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  Future<void> logout() async {
    await TokenStorage.clear();
  }
}