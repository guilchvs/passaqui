import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passaqui/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brazilian_banks/brazilian_banks.dart';
import 'profile_service.dart';

class AccountService {
  final String baseUrl =
      "http://passcash-api-hml.us-east-1.elasticbeanstalk.com/api";

  final AccountService _accountService = AccountService();
  final AuthService _authService = AuthService();

  Future<http.Response> saveBankAccount(
      {required int bankCode,
        required String agency,
        required String bankAccount}) async {
    final url = Uri.parse('$baseUrl/Account/cadastrarDadosBancarios');
    final cpf = await _authService.getCpf();
    final response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'cpf': cpf,
        'banco': bankCode,
        'agencia': agency,
        'conta': bankAccount
      }),
    );

    return response;
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