import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passaqui/src/services/auth_service.dart';

class AccountService {
  final String baseUrl =
      "http://passcash-api-hml.us-east-1.elasticbeanstalk.com/api";
  final AuthService _authService;

  AccountService(this._authService);

  Future<http.Response> saveBankAccount(
      {required int bankCode,
      required String agency,
      required String bankAccount,
      required String cpf,
      String? agencyDigit,
      String? bankAccountDigit}) async {
    final url = Uri.parse('$baseUrl/Account/cadastrarDadosBancarios');
    final token = await _authService.getToken();
    final Map<String, dynamic> body = {
      'cpf': cpf,
      'banco': bankCode,
      'agencia': agency,
      'conta': bankAccount,
    };


    if (agencyDigit != null && agencyDigit.isNotEmpty) {
      body['digitoAgencia'] = agencyDigit;
    }

    if (bankAccountDigit != null && bankAccountDigit.isNotEmpty) {
      body['digitoConta'] = bankAccountDigit;
    }

    final jsonBody = jsonEncode(body);

    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
       body: jsonBody,
      );

      // Debugging Information
      print('Request URL: $url');
      print('Request Headers: ${response.request?.headers}');
      print('Request Body: ${jsonEncode({
            'cpf': cpf,
            'banco': bankCode,
            'agencia': agency,
            'digitoAgencia': agencyDigit,
            'conta': bankAccount,
            'digitoConta': bankAccountDigit,
          })}');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode != 200) {
        print('Failed to save bank account: ${response.body}');
      }

      return response;
    } catch (e) {
      print('Exception caught: $e');
      rethrow;
    }
  }
}
