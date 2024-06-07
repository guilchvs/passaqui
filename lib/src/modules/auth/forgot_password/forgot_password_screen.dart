import 'package:flutter/material.dart';
import 'package:passaqui/src/core/app_theme.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/auth/forgot_password/success/forgot_password_success.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/text_field.dart';

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
