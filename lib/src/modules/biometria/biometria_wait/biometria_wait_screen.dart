import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';

class BiometriaWaitScreen extends StatefulWidget {
  static const String route = "/biometria_wait";

  const BiometriaWaitScreen({Key? key}) : super(key: key);

  @override
  State<BiometriaWaitScreen> createState() => _BiometriaWaitScreenState();
}

class _BiometriaWaitScreenState extends State<BiometriaWaitScreen> {
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
              'assets/images/il_processing_account.svg', // Replace with your SVG asset path
              height: 300, // Adjust the height as needed
            ),
            const SizedBox(height: 20), // Add spacing between widgets
            Text(
              'Seu pedido de antecipação está em andamento.',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),
            Text(
              'Ainda não terminaram de analisar seu pedido de crédito pessoal. Aguarde um pouco mais.',
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
                  LoginScreen.route,
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
