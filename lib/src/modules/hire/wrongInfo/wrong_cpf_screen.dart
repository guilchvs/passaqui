import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';

class WrongPersonalInfoScreen extends StatefulWidget {
  static const String route = "/wrong-info";
  final bool isEmail;

  const WrongPersonalInfoScreen({Key? key, required this.isEmail}) : super(key: key);

  @override
  State<WrongPersonalInfoScreen> createState() => _WrongPersonalInfoScreenState();
}

class _WrongPersonalInfoScreenState extends State<WrongPersonalInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String docOrEmail = 'e-mail';
    String destiny = 'e-mail';

    if (!widget.isEmail){
      docOrEmail = 'CPF';
      destiny = 'documento';
    }


    return Scaffold(
      appBar: const PassaquiAppBar(showBackButton: true, showLogo: false),
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              'assets/images/clipboard.svg', // Replace with your SVG asset path
              height: 300, // Adjust the height as needed
            ),
            const SizedBox(height: 20), // Add spacing between widgets
            Text(
              'Este $docOrEmail não é o seu?',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),
            Text(
              'Caso este não seja o seu CPF, é necessário acessar o app PaSSAqui com o seu ${destiny} para dar continuidade a sua solicitação. Havendo dúvidas, entre em contato com a nossa central de atendimento.',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            PassaquiButton(
              label: 'Entrar com a minha conta',
              centerText: true,
              borderRadius: 50,
              style: PassaquiButtonStyle.invertedPrimary,
              onTap: () {
                DIService().inject<NavigationHandler>().navigate(
                  LoginScreen.route,
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
