import 'package:flutter/material.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/auth/create-account/create_account_screen.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';
import 'package:passaqui/src/modules/auth/privacy_terms/privacy_terms_screen.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class WelcomeScreen extends StatelessWidget {
  static const String route = "/welcome";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Define breakpoints for small, medium, and large screens
    const smallScreenHeight = 600;
    const mediumScreenHeight = 800;

    // Adjust spacing based on screen size
    double topPadding;
    double logoHeight;
    double buttonSpacing;
    double bottomPadding;

    if (screenHeight <= smallScreenHeight) {
      topPadding = 0;
      logoHeight = 200;
      buttonSpacing = 20;
      bottomPadding = 10;
    } else if (screenHeight <= mediumScreenHeight) {
      topPadding = 20;
      logoHeight = 250;
      buttonSpacing = 30;
      bottomPadding = 40;
    } else {
      topPadding = 20;
      logoHeight = 300;
      buttonSpacing = 30;
      bottomPadding = 60;
    }

    Widget content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: topPadding),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/images/logo_passaqui_hor_1.png',
                width: logoHeight,
                height: logoHeight,
              ),
            ),
            const SizedBox(height: 260),
            PassaquiButton(
              label: 'Faça seu cadastro',
              width: 320,
              height: 50,
              centerText: true,
              onTap: () {

                DIService()
                    .inject<NavigationHandler>()
                    .navigate(PrivacyTermsScreen.route);

              },
              style: PassaquiButtonStyle.primary,
            ),
            SizedBox(height: buttonSpacing),
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
            SizedBox(height: bottomPadding),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/welcome_background.jpeg',
            fit: BoxFit.cover,
          ),
          screenHeight <= mediumScreenHeight
              ? SingleChildScrollView(child: content)
              : content,
        ],
      ),
    );
  }
}
