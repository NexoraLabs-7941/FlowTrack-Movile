import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/storage/token_storage.dart';
import '../models/provider_model.dart';

class ProviderService {
  final String baseUrl = "https://test-ru6s.onrender.com";

  Future<Map<String, String>> _headers() async {
    final token = await TokenStorage.getToken();

    return {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

  Future<List<Provider>> getProviders() async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/v1/providers"),
      headers: await _headers(),
    );

    if (res.statusCode != 200) {
      throw Exception("Error loading providers");
    }

    final List data = jsonDecode(res.body);
    return data.map((e) => Provider.fromJson(e)).toList();
  }
}