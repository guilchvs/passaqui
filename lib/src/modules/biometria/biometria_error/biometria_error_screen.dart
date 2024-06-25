import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/biometria/biometria_wait/biometria_wait_screen.dart';

class BiometriaErrorScreen extends StatefulWidget {
  static const String route = "/biometria_error";

  const BiometriaErrorScreen({Key? key}) : super(key: key);

  @override
  State<BiometriaErrorScreen> createState() => _BiometriaErrorScreenState();
}

class _BiometriaErrorScreenState extends State<BiometriaErrorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: const PassaquiAppBar(showBackButton: true, showLogo: false),
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              'assets/images/credit-denied.svg', // Replace with your SVG asset path
              height: 300, // Adjust the height as needed
            ),
            const SizedBox(height: 20), // Add spacing between widgets
            Text(
              'Seu pedido de crédito pessoal não foi aprovado.',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),
            Text(
              'Infelizmente não conseguimos validar seus dados e seu crédito não foi aprovado. Mas fique tranquilo, você poderá tentar novamente.',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            PassaquiButton(
              label: 'Voltar a tela inicial',
              centerText: true,
              borderRadius: 50,
              style: PassaquiButtonStyle.invertedPrimary,
              onTap: () {
                DIService().inject<NavigationHandler>().navigate(
                  BiometriaWaitScreen.route,
                );
              },
            ),
            const SizedBox(height: 16), // Add some spacing at the bottom
          ],
        ),
      ),
    );
  }
}
