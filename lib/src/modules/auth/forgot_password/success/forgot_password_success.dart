import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passaqui/src/core/app_theme.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class ForgotPasswordSuccessScreen extends StatefulWidget {
  static const String route = "/forgot-password-success";

  const ForgotPasswordSuccessScreen({super.key});

  @override
  State<ForgotPasswordSuccessScreen> createState() =>
      _ForgotPasswordSuccessScreenState();
}

class _ForgotPasswordSuccessScreenState
    extends State<ForgotPasswordSuccessScreen> {
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
                    height: 40,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 22),
                          Padding(
                            padding: EdgeInsets.only(left: 28.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "E-mail enviado!",
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
                                    "Não consegue encontrá-lo? Se não estiver na sua caixa de entrada, veja se não foi para a caixa de spam. Caso continue sem encontrar, clique baixo para reenviar.",
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
                    height: 240,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        PassaquiButton(
                          label: "Reenviar recuperação",
                          showArrow: true,
                          minimumSize: const Size(200, 40),
                          style: PassaquiButtonStyle.secondary,
                          onTap: () {
                            DIService()
                                .inject<NavigationHandler>()
                                .navigate(ForgotPasswordSuccessScreen.route);
                          },
                        ),
                        const SizedBox(height: 22),
                        PassaquiButton(
                          label: "Volte à tela de início",
                          showArrow: false,
                          centerText: true,
                          minimumSize: const Size(200, 40),
                          onTap: () {
                            DIService()
                                .inject<NavigationHandler>()
                                .navigate(LoginScreen.route);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
