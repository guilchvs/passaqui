import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/utils/format_cpf.dart';
import 'package:passaqui/src/utils/format_date.dart';
import 'package:passaqui/src/utils/format_phone_number.dart';

import '../../core/di/service_locator.dart';
import '../../core/navigation/navigation_handler.dart';
import '../../services/auth_service.dart';
import '../welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = "/profile";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = DIService().inject<AuthService>();

  late TextEditingController nameController;
  late TextEditingController cpfController;
  late TextEditingController emailController;
  late TextEditingController rgController;
  late TextEditingController telefoneController;
  late TextEditingController logradouroController;
  late TextEditingController numeroLogradouroController;
  late TextEditingController bairroController;
  late TextEditingController cidadeController;
  late TextEditingController ufController;
  late TextEditingController dataNascimentoController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  Future<void> _initializeControllers() async {
    try {
      final nome = await _authService.getName() ?? '';
      final cpf = await _authService.getCpf() ?? '';
      final email = await _authService.getEmail() ?? '';
      final rg = await _authService.getRg() ?? '';
      final telefone = await _authService.getTelefone() ?? '';
      final logradouro = await _authService.getLogradouro() ?? '';
      final numeroLogradouro = await _authService.getNumeroLogradouro() ?? '';
      final bairro = await _authService.getBairro() ?? '';
      final cidade = await _authService.getCidade() ?? '';
      final uf = await _authService.getUf() ?? '';
      final dataNascimento = await _authService.getDataNascimento() ?? '';

      setState(() {
        nameController = TextEditingController(text: nome);
        cpfController = TextEditingController(text: cpf);
        emailController = TextEditingController(text: email);
        rgController = TextEditingController(text: rg);
        telefoneController = TextEditingController(text: telefone);
        logradouroController = TextEditingController(text: logradouro);
        numeroLogradouroController =
            TextEditingController(text: numeroLogradouro);
        bairroController = TextEditingController(text: bairro);
        cidadeController = TextEditingController(text: cidade);
        ufController = TextEditingController(text: uf);
        dataNascimentoController = TextEditingController(text: dataNascimento);
      });
    } catch (e) {
      print('Error initializing controllers: $e');
    }
  }

  Future<void> _logout() async {
    try {
      await _authService.logout();
      // Navigate to login screen or perform any additional actions after logout
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      // Handle logout error
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(
        showBackButton: true,
        showLogo: false,
      ),
      backgroundColor: Color.fromRGBO(18, 96, 73, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                "Meu dados",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SvgPicture.asset(
                'assets/images/create_account.svg',
                height: 140,
                width: 140,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 22.0, right: 10, top: 12),
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  _buildInfoRow('Nome:', nameController.text),
                  _divider,
                  _buildInfoRow('E-mail:', emailController.text),
                  _divider,
                  _buildInfoRow('Data de Nascimento:',
                      formatDate(dataNascimentoController.text)),
                  _divider,
                  _buildInfoRow('CPF:', formatCpf(cpfController.text)),
                  _divider,
                  _buildInfoRow('RG:', rgController.text),
                  _divider,
                  _buildInfoRow(
                      'Telefone:', formatPhoneNumber(telefoneController.text)),
                  _divider,
                  _buildInfoRow('Logradouro:', logradouroController.text),
                  _divider,
                  _buildInfoRow(
                      'Número do Logradouro:', numeroLogradouroController.text),
                  _divider,
                  _buildInfoRow('Bairro:', bairroController.text),
                  _divider,
                  _buildInfoRow('Cidade:', cidadeController.text),
                  _divider,
                  _buildInfoRow('UF:', ufController.text),
                  const SizedBox(height: 38),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sair do aplicativo",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              decorationThickness: 1.5),
                        ),
                        const SizedBox(width: 12),
                        Image.asset(
                          "assets/images/logout.png",
                          color: Colors.white,
                          height: 24,
                          width: 24,
                        ),
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Logout"),
                            content: Text("Deseja mesmo sair do aplicativo?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Voltar ao app"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Sair"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _authService.logout();
                                  DIService()
                                      .inject<NavigationHandler>()
                                      .navigate(WelcomeScreen.route);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.visible, // Ensure full text is visible
          ),
        ),
      ],
    );
  }

  // Divider with the new color
  static const Divider _divider = Divider(
    color: Color(0xFFA8CA4B), // New color for the divider
    thickness: 1.0, // Thicker divider
  );
}
