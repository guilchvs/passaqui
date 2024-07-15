import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // final String baseUrl = "https://localhost:7151/api";
  final baseUrl = 'http://passcash-api-hml.us-east-1.elasticbeanstalk.com/api'; // Replace with your API base URL

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
      print(response.body);
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
    required String bairro,
    required String cidade,
    required String estado,
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
      'bairro': bairro,
      'cidade': cidade,
      'uf': estado,
    });

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    return response;
  }

Future<http.Response> enviarEmailAlteracaoSenha({required String email, required String bodyHtml}) async {
    final url = Uri.parse('$baseUrl/Account/enviarEmail');
    final corpoHtml = jsonEncode({
        'email': email,
        'subject': 'Alteração de Senha - PassCash',
        'body': bodyHtml
      });
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: corpoHtml
    );

    return response;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nome');
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<String?> getCpf() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cpf');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
  }


}
