import 'package:flutter/material.dart';
import 'package:passaqui/src/core/app_theme.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/auth/forgot_password/success/forgot_password_success.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/text_field.dart';
import 'package:passaqui/src/services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String route = "/forgot-password";

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  final AuthService _authService = AuthService();

 Future<void> enviarEmailAlteracaoSenha() async {
  final emailE = _emailController.text;

    try {
      final response = await _authService.enviarEmailAlteracaoSenha(
        email: emailE,
        bodyHtml: '<!DOCTYPE html> <html lang="en"> <head>     <meta charset="UTF-8">     <meta name="viewport" content="width=device-width, initial-scale=1.0">     <title>Recuperação de Conta - [Nome do Aplicativo]</title>     <style>         body {             font-family: Arial, sans-serif;             line-height: 1.6;             background-color: #f4f4f4;             margin: 0;             padding: 20px;         }         .container {             max-width: 600px;             margin: 0 auto;             background-color: #fff;             padding: 20px;             border-radius: 8px;             box-shadow: 0 0 10px rgba(0,0,0,0.1);         }         .button {             display: inline-block;             background-color: #007bff;             color: #fff;             text-decoration: none;             padding: 10px 20px;             border-radius: 5px;         }         .button:hover {             background-color: #0056b3;         }     </style> </head> <body>     <div class="container">         <h2 style="text-align: center; color: #007bff;">Recuperação de Conta - Passcash</h2>         <p>Prezado(a) [Nome do Usuário],</p>         <p>Recebemos uma solicitação de recuperação de conta para o seu perfil no aplicativo Passcash.</p>         <p>Para continuar com o processo de recuperação, clique no botão abaixo:</p>         <p><a href="https://localhost:7151/alterarSenha.html?email=" class="button">Recuperar Conta Agora</a></p>         <p>Se você não solicitou essa recuperação ou se acredita que tenha recebido este email por engano, por favor, ignore esta mensagem. Nenhuma alteração foi feita em sua conta até o momento.</p>         <p>Atenciosamente,<br>Equipe de Suporte Passcash</p>     </div> </body> </html>'
      );

      if (response.statusCode == 200) {
        print('Email enviado com sucesso!');
        //DIService().inject<NavigationHandler>().navigate(SuccessScreen.route);
      } else {
        throw Exception('Failed to register account: ${response.body}');
      }
    } catch (e) {
      print('Error registering account: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 16,
                ),
                Image.asset(
                  'assets/images/logo_passaqui_hor_1.png',
                  fit: BoxFit.cover,
                  height: 120,
                  width: 160,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.chevron_left,
                                color: Color(0xFFA8CA4B)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.only(left: 28.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Esqueceu sua senha?",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 34),
                              SizedBox(
                                width: 300,
                                child: Text(
                                  "Insira seu e-mail e \nenviaremos as instruções de redefinição de senha:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 56,
                ),
                PassaquiTextField(
                  editingController: _emailController,
                  placeholder: "Digite seu email",
                ),
                const SizedBox(height: 240),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: PassaquiButton(
                    label: "Continue",
                    showArrow: true,
                    minimumSize: const Size(200, 40),
                    onTap: () {
                      enviarEmailAlteracaoSenha();
                      DIService()
                          .inject<NavigationHandler>()
                          .navigate(ForgotPasswordSuccessScreen.route);
                    },
                  ),
                ),
              ]),
            )),
          ],
        ));
  }
}
