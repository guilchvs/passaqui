import 'package:flutter/material.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/auth/create-account/create_account_screen.dart';
import 'package:passaqui/src/modules/auth/forgot_password/forgot_password_screen.dart';
import 'package:passaqui/src/modules/auth/login/login_controller.dart';
import 'package:passaqui/src/modules/withdraw/welcome/withdraw_welcome_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/checkbox.dart';
import 'package:passaqui/src/shared/widget/link.dart';
import 'package:passaqui/src/shared/widget/text_field.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late LoginController controller;

  late TextEditingController userInputController;
  late TextEditingController passwordInputController;

  @override
  void initState() {
    controller = LoginController();
    userInputController = TextEditingController();
    passwordInputController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(showBackButton: false, showLogo: true),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26)),
                color: Color(0xFFF0F0F0),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 64,),
                  const Text(
                    "Acessar minha conta",
                    style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF136048),
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 56,),
                  PassaquiTextField(
                    editingController: userInputController,
                    label: "Usuário",
                  ),
                  const SizedBox(height: 16,),
                  PassaquiTextField(
                    editingController: passwordInputController,
                    label: "Senha",
                    isVisible: true,
                    showVisibility: true,
                  ),
                  const SizedBox(height: 16,),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PassaquiCheckBox(
                          label: "Lembrar senha",
                          onChanged: controller.setRememberPassword,
                          value: controller.rememberPassword,
                        ),
                        PassaquiLink(
                          label: "Esqueci a senha",
                          onTap: (){
                            DIService().inject<NavigationHandler>().navigate(ForgotPasswordScreen.route);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24
                    ),
                    child: PassaquiButton(
                      label: "Continuar",
                      minimumSize: const Size(200, 40),
                      onTap: (){
                        DIService().inject<NavigationHandler>().navigate(WithdrawWelcomeScreen.route);
                      },
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    width: double.infinity,
                    height: 1.4,
                    color: const Color(0xFF4D5D71),
                  ),
                  const SizedBox(height: 16,),
                  PassaquiLink(
                    label: "Criar uma conta",
                    onTap: (){
                      DIService().inject<NavigationHandler>().navigate(CreateAccountScreen.route);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
