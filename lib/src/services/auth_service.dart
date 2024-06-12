// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl;

  AuthService(this.baseUrl);

  Future<void> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['jwtToken'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', token);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
  }
}