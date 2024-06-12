import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:passaqui/src/core/app_theme.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/auth/forgot_password/forgot_password_screen.dart';
import 'package:passaqui/src/modules/auth/login/login_controller.dart';
import 'package:passaqui/src/modules/withdraw/welcome/withdraw_welcome_screen.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/checkbox.dart';
import 'package:passaqui/src/shared/widget/link.dart';
import 'package:passaqui/src/shared/widget/text_field.dart';
import '../../../services/auth_service.dart';

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
  final AuthService _authService = AuthService('http://passcash-api-hml.us-east-1.elasticbeanstalk.com/api/Account');

  bool isPasswordVisible = false;

  

  @override
  void initState() {
    controller = LoginController();
    userInputController = TextEditingController();
    passwordInputController = TextEditingController();
    super.initState();
  }

  Future<void> _login() async {
    final username = userInputController.text;
    final password = passwordInputController.text;

    try {
      await _authService.login(username, password);
      // Handle successful login, e.g., navigate to a new screen
      //print('Login successful');
      DIService()
        .inject<NavigationHandler>()
        .navigate(WithdrawWelcomeScreen.route);
    } catch (error) {
      // Handle login error
      print('Login failed: $error');
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
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
            child: Column(
              children: [
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
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.chevron_left, 
                              color: Color(0xFFA8CA4B)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.only(left: 24.0),
                          child: Text(
                            "Acesse sua conta:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 56,
                ),
                PassaquiTextField(
                  editingController: userInputController,
                  placeholder: "Digite seu email",
                ),
                const SizedBox(
                  height: 16,
                ),
                PassaquiTextField(
                  editingController: passwordInputController,
                  placeholder: "Digite sua senha",
                  isVisible: isPasswordVisible,
                  showVisibility: true,
                  toggleVisibility: togglePasswordVisibility,
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
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
                        underline: true,
                        onTap: () {
                          DIService()
                              .inject<NavigationHandler>()
                              .navigate(ForgotPasswordScreen.route);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: PassaquiButton(
                    label: "Continue",
                    showArrow: true,
                    minimumSize: const Size(200, 40),
                    onTap: () {
                      _login();
                      /*DIService()
                          .inject<NavigationHandler>()
                          .navigate(WithdrawWelcomeScreen.route);*/ 
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
