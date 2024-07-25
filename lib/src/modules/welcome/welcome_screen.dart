import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';
import 'package:passaqui/src/modules/auth/privacy_terms/privacy_terms_screen.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String route = "/welcome";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/welcome_background.jpeg',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'assets/images/logo_passaqui_hor_1.png',
                    width: screenWidth * 0.6,
                    height: screenWidth * 0.6,
                  ),
                ),
              ),
              Column(
                children: [
                  PassaquiButton(
                    label: 'Faça seu cadastro',
                    width: screenWidth * 0.8,
                    height: 50,
                    centerText: true,
                    onTap: () {
                      DIService()
                          .inject<NavigationHandler>()
                          .navigate(PrivacyTermsScreen.route);
                    },
                    style: PassaquiButtonStyle.primary,
                  ),
                  SizedBox(height: 20),
                  PassaquiButton(
                    label: 'Já tenho conta',
                    width: screenWidth * 0.8,
                    height: 50,
                    centerText: true,
                    style: PassaquiButtonStyle.secondary,
                    onTap: () {
                      DIService()
                          .inject<NavigationHandler>()
                          .navigate(LoginScreen.route);
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Versão $version',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Color(0xFF36454f),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

