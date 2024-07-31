import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/modules/profile/profile_screen.dart';
import 'package:passaqui/src/modules/profile/update-bank-account/update_bank_account_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/di/service_locator.dart';
import '../../core/navigation/navigation_handler.dart';
import '../../services/proposal_service.dart';
import '../home/home_page.dart';
import 'biometria_error_screen.dart';

class BiometriaSucessScreen extends StatefulWidget {
  static const String route = "/biometria_sucess";

  const BiometriaSucessScreen({Key? key}) : super(key: key);

  @override
  State<BiometriaSucessScreen> createState() => _BiometriaSucessScreenState();
}

class _BiometriaSucessScreenState extends State<BiometriaSucessScreen> {
  bool _isDownloading = false;
  final ProposalService _proposalService =
      DIService().inject<ProposalService>();

  @override
  void initState() {
    super.initState();
  }

  void _showDialog(String title, String message, {bool success = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (success) {
                  DIService()
                      .inject<NavigationHandler>()
                      .navigate(HomeScreen.route);
                } else {
                  //
                }
              },
              child: success
                  ? Text('Ir para Tela Inicial')
                  : Text('Tente novamente'),
            ),
          ],
        );
      },
    );
  }

  void _handleSendCCB() async {
    setState(() {
      _isDownloading = true; // Show loading indicator
    });

    try {
      final response = await _proposalService.sendCCBtoEmail();

      if (response['HasError'] == true) {
        print('Error: ${response['Message']}');
        _showDialog('Tente novamente', "Instabilidade na conexão");
      } else {
        print('Success: ${response['Message']}');
        _showDialog(
            'E-mail enviado!', 'Contrato enviado para e-mail com sucesso!',
            success: true);
      }
    } catch (e) {
      // print('Ocorreu um erro');
      // _showDialog('Erro', 'Erro ao enviar contrato');
    } finally {
      setState(() {
        _isDownloading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const PassaquiAppBar(showBackButton: true, showLogo: false),
      appBar: AppBar(
        backgroundColor: _isDownloading ? Colors.black.withOpacity(0.5) : Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  'assets/images/credit-approved.svg',
                  // Replace with your SVG asset path
                  height: 300, // Adjust the height as needed
                ),
                const SizedBox(height: 20), // Add spacing between widgets
                Text(
                  'Agora sim! Seus documentos foram aprovados e em poucos minutos o dinheiro estará na sua conta.',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    // 'Para continuarmos nosso processo, informe seus dados bancários clicando no botão abaixo',
                    'Para finalizar o processo, clique no botão abaixo. Em instantes você receberá seu contrato no e-mail cadastrado',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
                PassaquiButton(
                  label: 'Receber contrato no Email',
                  centerText: true,
                  borderRadius: 50,
                  style: PassaquiButtonStyle.invertedPrimary,
                  onTap: () {
                    // DIService().inject<NavigationHandler>().navigate(
                    //       UpdateBankProfileScreen.route,
                    //     );
                    _handleSendCCB();
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
          if (_isDownloading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//
//   return Scaffold(
//     appBar: const PassaquiAppBar(showBackButton: true, showLogo: false),
//     backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
//     body: SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SvgPicture.asset(
//             'assets/images/credit-approved.svg', // Replace with your SVG asset path
//             height: 300, // Adjust the height as needed
//           ),
//           const SizedBox(height: 20), // Add spacing between widgets
//           Text(
//             'Agora sim! Seus documentos foram aprovados!',
//             style: GoogleFonts.roboto(
//               color: Colors.white,
//               fontSize: 26,
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 26),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//               // 'Para continuarmos nosso processo, informe seus dados bancários clicando no botão abaixo',
//               'Para finalizar o processo, clique no botão abaixo. Em instantes você receberá seu contrato no e-mail cadastrado',
//               style: GoogleFonts.roboto(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w400,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           const SizedBox(height: 32),
//           PassaquiButton(
//             label: 'Receber contrato no Email',
//             centerText: true,
//             borderRadius: 50,
//             style: PassaquiButtonStyle.invertedPrimary,
//             onTap: () {
//               DIService().inject<NavigationHandler>().navigate(
//                 UpdateBankProfileScreen.route,
//               );
//             },
//           ),
//           const SizedBox(height: 16),
//           Center(
//             child: GestureDetector(
//               onTap: () {
//                 // Handle clickable text tap
//               },
//               child: Text(
//                 "Central de atendimento",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 18,
//                   fontFamily: 'Roboto',
//                   color: Colors.white,
//                   decoration: TextDecoration.underline,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 16), // Add some spacing at the bottom
//         ],
//       ),
//
//     ),
//
//   );
// }
}
