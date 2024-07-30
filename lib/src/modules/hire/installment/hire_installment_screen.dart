import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/core/app_config.dart';
import 'package:passaqui/src/modules/hire/value/hire_value_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/card.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import '../../../services/auth_service.dart';
import '../../../services/preference_service.dart'; // Import your AuthService

class HireInstallmentScreen extends StatefulWidget {
  static const String route = "/hire-installment";
  final String? cpf;

  const HireInstallmentScreen({Key? key, this.cpf}) : super(key: key);

  @override
  State<HireInstallmentScreen> createState() => _HireInstallmentScreenState();
}

class _HireInstallmentScreenState extends State<HireInstallmentScreen> {
  final AuthService _authService = DIService().inject<AuthService>();
  final TextEditingController _amountController = TextEditingController();
  String _selectedPeriod = '';
  bool _isLoading = false;
  String _buttonLabel = 'Simular';

  int _simulacaoPeriodo = 0;
  double _simulacaoVlrLiberado = 0.0;
  double _simulacaoVlrJuros = 0.0;
  double _simulacaoVlrOperacao = 0.0;
  double _simulacaoVlrEmprestimoCliente = 0.0;
  double _simulacaoTaxaMensal = 0.0;

  dynamic _jsonResponse;

  @override
  void initState() {
    super.initState();
    print('CPF received: ${widget.cpf}');
  }

  Future<void> _simulateApiCall(String cpf, double? amount) async {
    setState(() {
      _isLoading = true;
    });

    final token = await _authService.getToken();
    Uri url;

    if (amount != null) {
      url = Uri.parse('${AppConfig.api.apiMaster}/fazerSimulacaoFGTS?cpf=$cpf&vlrEmprestimo=$amount');
    } else {
      url = Uri.parse('${AppConfig.api.apiMaster}/fazerSimulacaoFGTS?cpf=$cpf');
    }

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Include Bearer token in headers
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Decoded JSON Response: $jsonResponse');

        setState(() {
          _jsonResponse = jsonResponse;

          if (jsonResponse['SimulacoesErro'] != null && jsonResponse['SimulacoesErro'].isNotEmpty) {
            String errorMessage = jsonResponse['SimulacoesErro'][0]['Msg'] ?? 'Erro desconhecido';
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Atenção'),
                  content: Text(errorMessage),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else if (jsonResponse['HasError'] == false) {
            if (jsonResponse['Simulacoes'] != null && jsonResponse['Simulacoes'].isNotEmpty) {
              var simulacao = jsonResponse['Simulacoes'][0];
              _simulacaoPeriodo = simulacao['Periodo'];
              _simulacaoVlrLiberado = simulacao['VlrLiberado'];
              _simulacaoVlrJuros = simulacao['VlrJuros'];
              _simulacaoVlrOperacao = simulacao['VlrOperacao'];
              _simulacaoVlrEmprestimoCliente = simulacao['VlrEmprestimoCliente'];
              _simulacaoTaxaMensal = simulacao['TaxaMensal'];
              _buttonLabel = 'Próximo';
            }
          } else {
            String errorDescription = 'Não conseguimos realizar a simulação. Tente novamente.';
            if (jsonResponse['Messages'] != null &&
                jsonResponse['Messages'].isNotEmpty &&
                jsonResponse['Messages'][0]['Description'] != null) {
              errorDescription = jsonResponse['Messages'][0]['Description'];
            }
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Atenção'),
                  content: Text(errorDescription),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    }
  }

  int _extractSelectedPeriodInt(String selectedPeriod) {
    return int.tryParse(selectedPeriod.split(' ')[0]) ?? 0;
  }

  Future<void> _saveSelectedPeriod(int selectedPeriod) async {
    await PreferenceService.saveSelectedPeriod(selectedPeriod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PassaquiAppBar(showBackButton: true, showLogo: false),
      backgroundColor: Color.fromRGBO(18, 96, 73, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Simulação de crédito",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 22),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  top: MediaQuery.of(context).size.height / 5,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: PassaquiCard(
                      height: 240,
                      backgroundColor: Colors.white,
                      content: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Quanto você deseja antecipar?",
                              style: GoogleFonts.inter(
                                color: Color(0xFF515151),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'R\$',
                                  style: GoogleFonts.inter(
                                    color: Color(0xFF136048),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Center(
                                    child: FocusScope(
                                      // Wrap with FocusScope
                                      child: TextFormField(
                                        controller: _amountController,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d*\.?\d{0,2}')),
                                        ],
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF136048),
                                          fontSize: 26,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '0,00',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          hintStyle: GoogleFonts.inter(
                                            color: Color(0xFF136048)
                                                .withOpacity(0.3),
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onEditingComplete: () {
                                          final amount = double.tryParse(
                                              _amountController.text
                                                  .replaceAll(',', '.'));
                                          if (amount != null) {
                                            _simulateApiCall(
                                                widget.cpf ?? '', amount);
                                            // Unfocus keyboard after API call
                                            FocusScope.of(context).unfocus();
                                          } else {
                                            // Handle invalid input
                                            print('Invalid amount entered');
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "min: R\$ 200,00",
                                  style: GoogleFonts.inter(
                                    color: Color(0xFF515151),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "max: R\$ 4000,00",
                                  style: GoogleFonts.inter(
                                    color: Color(0xFF515151),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 270,
                  right: 0,
                  left: 0,
                  child: _jsonResponse != null &&
                      !_jsonResponse['HasError'] &&
                      (_jsonResponse['SimulacoesErro'] == null || _jsonResponse['SimulacoesErro'].isEmpty)
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Número de períodos: ",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "$_simulacaoPeriodo",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Valor solicitado: ",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "R\$ ${_simulacaoVlrLiberado.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Valor do empréstimo: ",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "R\$ ${_simulacaoVlrEmprestimoCliente.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Taxa Mensal: ",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${_simulacaoTaxaMensal.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Valor Juros: ",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "R\$ ${_simulacaoVlrJuros.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: const Divider(
                          thickness: 2.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Valor Total da Operação: ",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "R\$ ${_simulacaoVlrOperacao.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 64),
                      PassaquiButton(
                        label: _buttonLabel,
                        style: PassaquiButtonStyle.primary,
                        showArrow: true,
                        onTap: () {
                          final amount = double.tryParse(
                              _amountController.text.replaceAll(',', '.'));
                          _simulateApiCall(widget.cpf ?? '', amount);
                          FocusScope.of(context).unfocus();

                          // Navigate to HireValueScreen with jsonResponse as argument
                          if (_jsonResponse != null) {
                            if (_selectedPeriod.isEmpty) {
                              setState(() {
                                _selectedPeriod = '1';
                              });
                            }
                            int selectedPeriodInt =
                                _extractSelectedPeriodInt(_selectedPeriod);
                            _saveSelectedPeriod(selectedPeriodInt);
                            DIService().inject<NavigationHandler>().navigate(
                              HireValueScreen.route,
                              arguments: {
                                'jsonResponse': _jsonResponse,
                                'cpf': widget.cpf,
                                'selectedPeriod': selectedPeriodInt as int
                              },
                            );
                          } else {
                            print('No JSON response available');
                            print(_jsonResponse);
                          }
                        },
                      ),
                    ],
                  ) : Center(
                    child: Text(
                      "Preencha o campo acima para iniciar a simulação"
                    )
                  ),
                ),
                if (_isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

