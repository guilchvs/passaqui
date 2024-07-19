import 'dart:convert';
import 'package:brazilian_banks/brazilian_banks.dart';
import 'package:http/http.dart' as http;
import 'package:passaqui/src/services/auth_service.dart';

import '../../core/app_config.dart';

class AccountService {

  final baseUrl = AppConfig.baseUrl;
  final AuthService _authService;

  AccountService(this._authService);

  Future<http.Response> saveBankAccount(
      {required int bankCode,
      required String agency,
      required String account,
      required String cpf,
        required accountDigit,
      String? agencyDigit,
      String? bankAccountDigit}) async {
    final url = Uri.parse('$baseUrl/api/Account/cadastrarDadosBancarios');
    final token = await _authService.getToken();
    final Map<String, dynamic> body = {
      'cpf': cpf,
      'banco': bankCode,
      'agencia': agency,
      'conta': account,
    };


    if (agencyDigit != null && agencyDigit.isNotEmpty) {
      body['digitoAgencia'] = agencyDigit;
    }

    if (bankAccountDigit != null && bankAccountDigit.isNotEmpty) {
      body['digitoConta'] = accountDigit;
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
            'conta': account,
            'digitoConta': accountDigit,
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

  Future<List<BrasilApiBanks>> getBrazilianBanksList() async {
    final banks = await BrasilApiBanks.getBanks();
    return banks;
  }

  Future<dynamic> getBankAccountValidadion(
      {required int bankCode,
        required String branchNumber,
        required String accountNumberWithDigit,
        required String accountType}) async {
    var response = BankAccountValidationService().validateAccountNumber(
      bankAccountModel: BankAccountModel(
          bankCode: bankCode,
          branchNumber: branchNumber,
          accountNumberWithDigit: accountNumberWithDigit,
          accountType: AccountType.checking),
    );

    if (response.errorMessage == null) {
      if (response.isValid!) {
        print('account digit is correct');
        return 'account digit is correct';
      } else {
        print('the correct account digit probably is ${response.digit}');
        return 'the correct account digit probably is ${response.digit}';
      }
    } else {
      print(response.errorMessage);
    }

    return response;
  }



}
