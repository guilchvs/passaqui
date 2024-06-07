import 'package:flutter/material.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/auth/create-account/create_account_screen.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const String route = "/welcome";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/welcome_background.jpeg',
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 10,
            right: 10,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/logo_passaqui_hor_1.png',
                      width: 300,
                      height: 300,
                    ),
                  ),
                  const SizedBox(height: 360),
                  PassaquiButton(
                    label: 'Faça seu cadastro',
                    width: 320,
                    height: 50,
                    centerText: true,
                    onTap: () {
                      DIService()
                          .inject<NavigationHandler>()
                          .navigate(CreateAccountScreen.route);
                    },
                    style: PassaquiButtonStyle.primary,
                  ),
                  const SizedBox(height: 30),
                  PassaquiButton(
                    label: 'Já tenho conta',
                    width: 320,
                    height: 50,
                    centerText: true,
                    style: PassaquiButtonStyle.secondary,
                    onTap: () {
                      DIService()
                          .inject<NavigationHandler>()
                          .navigate(LoginScreen.route);
                    },
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
