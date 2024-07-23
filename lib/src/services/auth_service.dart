import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_config.dart';

class AuthService {
  Future<void> login(String username, String password) async {
    final url = Uri.parse('${AppConfig.api.account}/login');
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
      print("BODY: $responseBody");
      final token = responseBody['jwtToken'];
      final nome = responseBody['nome'];
      final cpf = responseBody['cpf'];
      final email = responseBody['email'];
      final rg = responseBody['rg'];
      final telefone = responseBody['telefone'];
      final logradouro = responseBody['logradouro'];
      final numeroLogradouro = responseBody['numeroLogradouro'].toString();
      final bairro = responseBody['bairro'];
      final cidade = responseBody['cidade'];
      final UF = responseBody['uf'];
      final dataNascimento = responseBody['dataNascimento'];
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('jwt', token);
      await prefs.setString('nome', nome);
      await prefs.setString('cpf', cpf);
      await prefs.setString('email', email);
      await prefs.setString('rg', rg);
      await prefs.setString('telefone', telefone);
      await prefs.setString('logradouro', logradouro);
      await prefs.setString('numeroLogradouro', numeroLogradouro);
      await prefs.setString('bairro', bairro);
      await prefs.setString('cidade', cidade);
      await prefs.setString('uf', UF);
      await prefs.setString('dataNascimento', dataNascimento);
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
    final url = Uri.parse('${AppConfig.api.account}/register');
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

  Future<http.Response> enviarEmailAlteracaoSenha({
    required String email,
    required String bodyHtml,
  }) async {
    final url = Uri.parse('${AppConfig.api}/Account/enviarEmail');
    final corpoHtml = jsonEncode({
      'email': email,
      'subject': 'Alteração de Senha - PassCash',
      'body': bodyHtml,
    });
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: corpoHtml,
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

  Future<String?> getRg() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('rg');
  }

  Future<String?> getTelefone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('telefone');
  }

  Future<String?> getLogradouro() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('logradouro');
  }

  Future<String?> getNumeroLogradouro() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('numeroLogradouro');
    //final numero = prefs.getString('numeroLogradouro');
    // return numero != null
    //     ? int.tryParse(numero)
    //     : null; // Convert from String to int
  }

  Future<String?> getBairro() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('bairro');
  }

  Future<String?> getCidade() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cidade');
  }

  Future<String?> getUf() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uf');
  }

  Future<String?> getDataNascimento() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('dataNascimento');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    await prefs.remove('nome');
    await prefs.remove('email');
    await prefs.remove('cpf');
    await prefs.remove('rg');
    await prefs.remove('telefone');
    await prefs.remove('logradouro');
    await prefs.remove('numeroLogradouro');
    await prefs.remove('bairro');
    await prefs.remove('cidade');
    await prefs.remove('UF');
    await prefs.remove('dataNascimento');
  }
}
