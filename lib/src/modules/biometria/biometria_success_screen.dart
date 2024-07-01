import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/modules/profile/profile_screen.dart';
import 'package:passaqui/src/modules/profile/update-bank-account/update_profile_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';

import '../../core/di/service_locator.dart';
import '../../core/navigation/navigation_handler.dart';
import 'biometria_error_screen.dart';

class BiometriaSucessScreen extends StatefulWidget {
  static const String route = "/biometria_sucess";

  const BiometriaSucessScreen({Key? key}) : super(key: key);

  @override
  State<BiometriaSucessScreen> createState() => _BiometriaSucessScreenState();
}

class _BiometriaSucessScreenState extends State<BiometriaSucessScreen> {
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
              'assets/images/credit-approved.svg', // Replace with your SVG asset path
              height: 300, // Adjust the height as needed
            ),
            const SizedBox(height: 20), // Add spacing between widgets
            Text(
              'Agora sim! Seus documentos foram aprovados!',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),
            Text(
              'Para continuarmos nosso processo, informe seus dados bancários clicando no botão abaixo',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            PassaquiButton(
              label: 'Adicionar dados bancários',
              centerText: true,
              borderRadius: 50,
              style: PassaquiButtonStyle.invertedPrimary,
              onTap: () {
                DIService().inject<NavigationHandler>().navigate(
                  UpdateBankProfileScreen.route,
                );
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: () {
                  // Handle clickable text tap
                },
                child: Text(
                  "Central de atendimento",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // Add some spacing at the bottom
          ],
        ),
      ),
    );
  }
}