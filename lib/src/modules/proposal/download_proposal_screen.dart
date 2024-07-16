// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:passaqui/src/services/proposal_service.dart';
// import 'package:passaqui/src/core/di/service_locator.dart';
// import 'package:passaqui/src/services/auth_service.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
//
// class DownloadProposalScreen extends StatefulWidget {
//   static const String route = "/download-proposal";
//
//   const DownloadProposalScreen({super.key});
//
//   @override
//   State<DownloadProposalScreen> createState() => _DownloadProposalScreenState();
// }
//
// class _DownloadProposalScreenState extends State<DownloadProposalScreen> {
//   bool _isDownloading = false;
//   final AuthService _authService = DIService().inject<AuthService>();
//   final ProposalService _proposalService = DIService().inject<ProposalService>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: SvgPicture.asset(
//                     'assets/images/receive-money.svg',
//                     height: 300, // Adjust the height as needed
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(bottom: 22.0),
//                   child: Text(
//                     'Agora falta pouco!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white,
//                       height: 1.5,
//                     ),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     'Em instantes, você receberá seu contrato pelo e-mail cadastrado!\n\n',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white,
//                       height: 1.5,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 200),
//                         child: PassaquiButton(
//                           label: 'Clique para finalizar',
//                           centerText: true,
//                           minimumSize: const Size(200, 40),
//                           style: PassaquiButtonStyle.defaultLight,
//                           onTap: () {
//                             _handleSendCCB();
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Loading Indicator
//             if (_isDownloading)
//               Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _handleSendCCB() async {
//     setState(() {
//       _isDownloading = true; // Show loading indicator
//     });
//
//     try {
//       final response = await _proposalService.sendCCBtoEmail();
//
//       if (response['HasError'] == true) {
//         print('Error: ${response['Message']}');
//         _showDialog('Erro', response['Message']);
//       } else {
//         print('Success: ${response['Message']}');
//         _showDialog('Sucesso!', 'O contrato foi enviado para seu e-mail!', success: true);
//       }
//     } catch (e) {
//       print('Exception: $e');
//       _showDialog('Erro', 'Erro ao enviar contrato');
//     } finally {
//       setState(() {
//         _isDownloading = false; // Hide loading indicator
//       });
//     }
//   }
//
//   void _showDialog(String title, String message, {bool success = false}) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 if (success) {
//                   // Navigate to HomeScreen on success
//                 }
//               },
//               child: Text('Ir para a Home'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/services/proposal_service.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/services/auth_service.dart';
import 'package:passaqui/src/shared/widget/button.dart';

import '../../core/navigation/navigation_handler.dart';

class DownloadProposalScreen extends StatefulWidget {
  static const String route = "/download-proposal";

  const DownloadProposalScreen({super.key});

  @override
  State<DownloadProposalScreen> createState() => _DownloadProposalScreenState();
}

class _DownloadProposalScreenState extends State<DownloadProposalScreen> {
  bool _isDownloading = false;
  final AuthService _authService = DIService().inject<AuthService>();
  final ProposalService _proposalService = DIService().inject<ProposalService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: SvgPicture.asset(
                    'assets/images/receive-money.svg',
                    height: 300, // Adjust the height as needed
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 22.0),
                  child: Text(
                    'Agora falta pouco!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Em instantes, você receberá seu contrato pelo e-mail cadastrado!\n\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 200),
                        child: PassaquiButton(
                          label: 'Clique para finalizar',
                          centerText: true,
                          minimumSize: const Size(200, 40),
                          style: PassaquiButtonStyle.defaultLight,
                          onTap: () {
                            _handleSendCCB();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Loading Indicator with semi-transparent overlay
            if (_isDownloading)
              Stack(
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
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
        _showDialog('E-mail Enviado!', 'Contrato enviado para e-mail com sucesso!', success: true);
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
                  DIService().inject<NavigationHandler>().navigate(HomeScreen.route);
                } else {
                  //
                }
              },
              child: success ? Text('Ir para Tela Inicial') : Text('Tente novamente'),
            ),
          ],
        );
      },
    );
  }
}
