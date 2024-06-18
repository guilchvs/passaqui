import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://passcash-api-hml.us-east-1.elasticbeanstalk.com/api";

  Future<void> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/Account/login');
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
      print(response.body);
      final token = responseBody['jwtToken'];
      final nome = responseBody['nome'];
      final cpf = responseBody['cpf'];
      final email = responseBody['email'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', token);
      await prefs.setString('nome', nome);
      await prefs.setString('cpf', cpf);
      await prefs.setString('email', email);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<http.Response> register({
    required String email,
    required String name,
    required String password,
    required String confirmPassword,
    required String cpf,
    required String telefone,
    required String cep,
    required String logradouro,
    required int numeroLogradouro,
    required String complemento,
    required String dataNascimento,
    required String rg,
  }) async {
    final url = Uri.parse('$baseUrl/Account/register');
    final body = jsonEncode({
      'email': email,
      'name': name,
      'password': password,
      'confirmPassword': confirmPassword,
      'cpf': cpf,
      'role': 'user',
      'telefone': telefone,
      'cep': cep,
      'logradouro': logradouro,
      'numeroLogradouro': numeroLogradouro,
      'complemento': complemento,
      'dataNascimento': dataNascimento,
      'rg': rg,
    });

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    return response; // Return the HTTP response object
  }
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nome');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
  }


}
