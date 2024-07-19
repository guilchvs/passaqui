import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passaqui/src/core/app_config.dart';
import 'package:passaqui/src/services/auth_service.dart';
import 'package:passaqui/src/services/preference_service.dart';
import 'package:passaqui/src/services/proposal_service.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../core/di/service_locator.dart';
import '../../core/navigation/navigation_handler.dart';
import '../hire/biometria/hire_biometria_screen.dart';

class SendProposalScreen extends StatefulWidget {
  static const String route = "/send-proposal";

  const SendProposalScreen({Key? key}) : super(key: key);

  @override
  State<SendProposalScreen> createState() => _SendProposalScreenState();
}

class _SendProposalScreenState extends State<SendProposalScreen> {
  late PageController _pageController;
  final AuthService _authService = DIService().inject<AuthService>();
  final ProposalService _proposalService =
      DIService().inject<ProposalService>();
  final PreferenceService _preferenceService =
      DIService().inject<PreferenceService>();
  String userName = '';
  bool _isLoading = false;

  Future<void> loadUserName() async {
    try {
      final name = await _authService.getName();
      setState(() {
        userName = name ?? ''; // Update the userName variable
      });
    } catch (e) {
      print('Failed to load user name: $e');
    }
  }

  Future<void> _simulateApiCall(String? cpf) async {
    setState(() {
      _isLoading = true;
    });
    print("CPF DO USUARIO: $cpf");

    final baseUrl = AppConfig.baseUrl;
    final token = await _authService.getToken(); // Retrieve JWT token
    final url = Uri.parse('$baseUrl/api/ApiMaster/iniciarBiometria?cpf=$cpf');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Include Bearer token in headers
        },
      );

      if (response.statusCode == 200) {
        final _url = response.body;
        DIService().inject<NavigationHandler>().navigate(
          HireBiometriaScreen.route,
          arguments: {'url': _url},
        );
        //await launchUrlString(_url);
      } else if (response.statusCode == 504) {
        print('Failed to load data: ${response.statusCode}');
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tente novamente'),
            content: Text('Instabilidade na conexão'),
            actions:
                 [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tentar novamente'),
              ),
            ]
          );
        },
        );
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    }
  }

  Future<void> handleSendProposal() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cpf = await _authService.getCpf();
    final periodo =
        prefs.getInt('selectedPeriod') ?? 1; // Default to 1 if not found
    final vlrEmprestimo =
        prefs.getDouble('vlrEmprestimo') ?? 0.0; // Default to 0.0 if not found

    Map<String, dynamic> responseBody =
        await _proposalService.sendProposal(cpf, periodo, vlrEmprestimo);

    print('RESPONSE BODY : $responseBody');
    bool hasError = responseBody['HasError'] == true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(hasError ? 'Erro ao enviar proposta' : 'Sucesso'),
          content: Text(hasError
              ? 'Não foi possível enviar sua proposta. Verifique seus dados e tente novamente'
              : 'Proposta enviada com sucesso!'),
          actions: hasError
              ? [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ]
              : [
                  TextButton(
                    onPressed: () {
                      this._simulateApiCall(cpf);
                      Navigator.of(context).pop();
                      if (!hasError) {
                        //
                      }
                    },
                    child: Text('Prosseguir'),
                  ),
                ],
        );
      },
    );

    setState(() {
      _isLoading = false; // Hide loading indicator
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    loadUserName();
    _printSelectedPeriod();
    super.initState();
  }

  Future<void> _printSelectedPeriod() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedPeriod = prefs.getInt('selectedPeriod');
    print('Selected Period: $selectedPeriod');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    'assets/images/credit-approved.svg',
                    // Replace with your SVG asset path
                    height: 300, // Adjust the height as needed
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    "Oba! Para dar prosseguimento no processo, basta clicar em enviar proposta!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: PassaquiButton(
                            label: "Enviar Proposta",
                            showArrow: true,
                            minimumSize: const Size(200, 40),
                            onTap: () {
                              handleSendProposal();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
    );
  }
}
