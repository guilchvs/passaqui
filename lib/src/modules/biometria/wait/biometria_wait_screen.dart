import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import '../../../services/biometria_service.dart';
import '../biometria_error_screen.dart';
import '../biometria_success_screen.dart';

class BiometriaWaitScreen extends StatefulWidget {
  static const String route = "/biometria_wait";

  const BiometriaWaitScreen({Key? key}) : super(key: key);

  @override
  State<BiometriaWaitScreen> createState() => _BiometriaWaitScreenState();
}

class _BiometriaWaitScreenState extends State<BiometriaWaitScreen> with RouteAware {
  late Timer _timer;
  int _biometriaResult = 0;
  final BiometriaService _biometriaService = DIService().inject<BiometriaService>();


  @override
  void initState() {
    super.initState();
    print("Print");
    _timer = Timer(Duration(seconds: 5), () {
      // print("Fetching API every 5 seconds!");
      //fetchBiometriaData();
      DIService().inject<NavigationHandler>().navigate(BiometriaSucessScreen.route);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void fetchBiometriaData() async {
    _biometriaResult = await _biometriaService.fetchBiometriaData();

    print('Biometria Result: $_biometriaResult');

    if (_biometriaResult == 1) {
      DIService().inject<NavigationHandler>().navigate(BiometriaErrorScreen.route);
      _timer.cancel();
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
              'assets/images/il_processing_account.svg',
              height: 300,
            ),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(height: 40),
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
              'Ainda não terminaram de analisar seus documentos. Aguarde um pouco mais.',
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

