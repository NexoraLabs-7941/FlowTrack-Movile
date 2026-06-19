import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthController extends ChangeNotifier {
  bool isLoading = false;
  String? token;
  String? error;

  // 🌐 BACKEND REAL (RENDER)
  final String baseUrl =
      "https://test-ru6s.onrender.com";

  // =========================
  // LOGIN
  // =========================
  Future<bool> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/sign-in"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print("LOGIN STATUS: ${response.statusCode}");
      print("LOGIN BODY: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        token = data["token"];
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        error = data["message"] ?? "Error al iniciar sesión";
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("LOGIN ERROR: $e");
      error = "Error de conexión con servidor";
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // =========================
  // REGISTER
  // =========================
  Future<bool> register(String email, String password) async {
  isLoading = true;
  error = null;
  notifyListeners();

  try {
    final response = await http.post(
      Uri.parse("$baseUrl/sign-up"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    print("========== REGISTER DEBUG ==========");
    print("URL: $baseUrl/sign-up");
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");
    print("====================================");

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      final data = jsonDecode(response.body);
      token = data["token"];
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      error = response.body; // 🔥 IMPORTANTE: ver error real
      isLoading = false;
      notifyListeners();
      return false;
    }

  } catch (e) {
    print("REGISTER ERROR: $e");
    error = e.toString();
    isLoading = false;
    notifyListeners();
    return false;
  }
}

  // =========================
  // LOGOUT
  // =========================
  void logout() {
    token = null;
    notifyListeners();
  }
}