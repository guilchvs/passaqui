import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import '../biometria_error_screen.dart';
import '../biometria_success_screen.dart';

class BiometriaWaitScreen extends StatefulWidget {
  static const String route = "/biometria_wait";

  const BiometriaWaitScreen({Key? key}) : super(key: key);

  @override
  State<BiometriaWaitScreen> createState() => _BiometriaWaitScreenState();
}

class _BiometriaWaitScreenState extends State<BiometriaWaitScreen> {
  late Timer _timer;
  int? _biometriaResult; // Variable to store fetched result, assuming it's an integer

  @override
  void initState() {
    super.initState();

    // Start calling fetchBiometriaData() every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      print("Fetching API every 5 seconds!");
      fetchBiometriaData();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the state is disposed
    _timer.cancel();
    super.dispose();
  }

  void fetchBiometriaData() {
    // Replace with your actual API call logic to fetch biometria data
    // Simulating a result for demonstration
    _biometriaResult = 0; // Replace with your actual fetched result (0, 1, or 2)

    print('Biometria Result: $_biometriaResult'); // Print the fetched result

    if (_biometriaResult == 1) {
      DIService().inject<NavigationHandler>().navigate(BiometriaErrorScreen.route);
      _timer.cancel(); // Stop timer once valid result is received
    } else if (_biometriaResult == 2) {
      DIService().inject<NavigationHandler>().navigate(BiometriaSucessScreen.route);
      _timer.cancel(); // Stop timer once valid result is received
    }
    // If result is neither 1 nor 2, do nothing and continue calling fetchBiometriaData()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(showBackButton: false, showLogo: false),
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
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(height: 40), // Add spacing between widgets
            Text(
              'Seu pedido de antecipação está em andamento.',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),
            Text(
              'Ainda não terminaram de analisar seu pedido de crédito pessoal. Aguarde um pouco mais.',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // PassaquiButton(
            //   label: 'Voltar a tela inicial',
            //   centerText: true,
            //   borderRadius: 50,
            //   style: PassaquiButtonStyle.invertedPrimary,
            //   onTap: () {
            //     DIService().inject<NavigationHandler>().navigate(
            //       HomeScreen.route,
            //     );
            //   },
            // ),
            const SizedBox(height: 16), // Add some spacing at the bottom
          ],
        ),
      ),
    );
  }
}

