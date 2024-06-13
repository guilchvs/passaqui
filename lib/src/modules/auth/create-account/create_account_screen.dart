import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:passaqui/src/services/auth_service.dart'; // Adjust the import path as per your project structure
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/text_field.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String route = "/create-account";

  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  late List<TextEditingController> controllers;
  List<String> labels = [
    "Bem vindo ao PassAqui!\n\nPara começar precisamos de algumas informações. Será rápido e fácil.",
    "Informe seu e-mail",
    "Agora nos informe sua senha:",
    "Repita sua senha:",
    "Insira seu CPF no campo abaixo:",
    "Agora informe seu telefone:",
    "Estamos quase finalizando.\nInforme seu e-mail no campo abaixo:",
    "Agora precisamos do seu RG:",
    "Agora entramos na etapa sobre sua residência.\n\nPedimos que insira seu CEP:",
    "Insira abaixo o nome do logradouro, por favor:",
    "Agora informe o número da sua residência:",
    "Para terminar, informe (se necessário) o complemento da localização de sua residência:"
  ];

  List<String> placeholders = [
    "Digite seu nome completo",
    "Digite seu e-mail",
    "Digite sua senha",
    "Digite sua senha novamente",
    "Digite seu CPF",
    "Digite seu telefone",
    "Digite seu e-mail",
    "Digite seu RG",
    "Digite seu CEP",
    "Digite seu logradouro",
    "Digite seu número",
    "Digite o complemento",
  ];

  final AuthService _authService = AuthService(
      'https://your-base-url.com'); // Replace with your actual base URL

  @override
  void initState() {
    _pageController = PageController();
    controllers =
        List.generate(labels.length, (index) => TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void nextPage() {
    if (_currentPageIndex < labels.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPageIndex++;
      });
    } else {
      _registerAccount();
    }
  }

  Future<void> _registerAccount() async {
    try {
      await _authService.register(
        email: controllers[5].text.trim(),
        name: controllers[0].text.trim(),
        password: controllers[1].text.trim(),
        confirmPassword: controllers[2].text.trim(),
        cpf: controllers[3].text.trim(),
        telefone: controllers[4].text.trim(),
        cep: controllers[8].text.trim(),
        logradouro: controllers[9].text.trim(),
        numeroLogradouro: int.tryParse(controllers[10].text.trim()) ?? 0,
        complemento: controllers[11].text.trim(),
        dataNascimento: controllers[7].text.trim(),
        rg: controllers[6].text.trim(),
      );

      // Handle navigation or success message after successful registration
      // Example:
      // Navigator.of(context).pushNamed(SuccessScreen.route);
    } catch (e) {
      // Handle error, show error message or retry logic
      print('Failed to register account: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Hide back button
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: (_currentPageIndex + 1) / labels.length,
            valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFFA8CA4B)),
            backgroundColor: Colors.white,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                ),
                color: Colors.white,
              ),
              child: PageView.builder(
                controller: _pageController,
                itemCount: labels.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32),
                        Text(
                          labels[index],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (index == 5) // Check if it's the date of birth step
                          GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: const Color(0xFFA8CA4B),
                                        // Header background color
                                        onPrimary: Colors.white,
                                        // Header text color
                                        surface: Colors.white,
                                        // Background color
                                        onSurface: Colors.black, // Text color
                                      ),
                                      dialogBackgroundColor:
                                      Colors.white, // Background color
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (picked != null &&
                                  picked != controllers[index].text) {
                                setState(() {
                                  controllers[index].text = picked.toString();
                                });
                              }
                            },
                            child: AbsorbPointer(
                              absorbing: true,
                              // Absorb gestures to prevent user input
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.grey[200], // Placeholder color
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                        color: Colors.grey),
                                    SizedBox(width: 10),
                                    Text(
                                      controllers[index].text.isEmpty
                                          ? 'DD/MM/YYYY'
                                          : controllers[index].text,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        else // For other steps, show regular text field
                          PassaquiTextField(
                            editingController: controllers[index],
                            placeholder: placeholders[index],
                            textColor: Colors.black,
                          ),
                        const SizedBox(height: 40),
                        const Spacer(),
                        PassaquiButton(
                          label: index == labels.length - 1
                              ? "Continue"
                              : "Continue",
                          showArrow: true,
                          minimumSize: Size(200, 40),
                          onTap: nextPage,
                        ),
                      ],
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
