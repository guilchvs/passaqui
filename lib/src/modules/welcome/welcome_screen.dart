import 'package:flutter/material.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/auth/create-account/create_account_screen.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';
import 'package:passaqui/src/shared/widget/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const String route = "/welcome";

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset('assets/images/passaqui_nav_logo.jpeg',
                  width: 300, height: 300),
            ),
            const SizedBox(height: 180),
            WelcomeButton(
              label: 'Abra sua conta',
              onTap: () {
                DIService()
                    .inject<NavigationHandler>()
                    .navigate(CreateAccountScreen.route);
              },
            ),
            const SizedBox(height: 30),
            WelcomeButton(
              label: 'Acesse sua conta',
              isSecondary: true,
              onTap: () {
                DIService()
                    .inject<NavigationHandler>()
                    .navigate(LoginScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
