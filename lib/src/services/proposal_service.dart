import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProposalService {
  Future<Map<String, dynamic>> sendProposal(String? cpf, int periodo, double vlrEmprestimo) async {
    final AuthService _authService = DIService().inject<AuthService>();
    final baseUrl = 'http://passcash-api-hml.us-east-1.elasticbeanstalk.com'; // Replace with your API base URL
    final token = await _authService.getToken();

    Uri url = Uri.parse('$baseUrl/api/ApiMaster/enviarPropostaSaqueAniversario').replace(queryParameters: {
      'cpf': cpf,
      'periodo': periodo.toString(),
      'vlrEmprestimo': vlrEmprestimo.toString(),
    });

    // final requestBody = {
    //   'cpf': cpf,
    //   'periodo': periodo,
    //   'vlrEmprestimo': vlrEmprestimo,
    // };

    // final requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print('CPF: $cpf; periodo: $periodo; vlrEmprestimo: $vlrEmprestimo');

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> responseBody = json.decode(response.body);
          return responseBody;
        } catch (e) {
          print('Error decoding JSON: $e');
          return {'HasError': false, 'Message': 'Error decoding JSON.'};
        }
      } else {
         print('Erro ao enviar proposta. Status code: ${response.statusCode}\n Response: ${response.body}');
         return {'HasError': true, 'Message': 'Erro ao enviar proposta. ${response.body}'};
      }
    } catch (e) {
      print('Erro ao enviar proposta: $e');
      return {'HasError': true, 'Message': 'Exception: $e'};
    }
  }

  Future<Map<String, dynamic>> sendCCBtoEmail() async {
    final AuthService _authService = DIService().inject<AuthService>();
    final baseUrl = 'http://passcash-api-hml.us-east-1.elasticbeanstalk.com'; // Replace with your API base URL
    final token = await _authService.getToken();

    Uri url = Uri.parse('$baseUrl/api/ApiMaster/downloadCCB');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> responseBody = json.decode(response.body);
          return responseBody;
        } catch (e) {
          return {'Message': 'Error sending JSON.'};
        }
      } else {
        print('Erro ao enviar contrato. Status code: ${response.statusCode}\n Response: ${response.body}');
        return {'HasError': true, 'Message': 'Erro ao enviar contrato. ${response.body}'};
      }
    } catch (e) {
      print('Erro ao enviar contrato: $e');
      return {'HasError': true, 'Message': 'Exception: $e'};
    }
  }
}
