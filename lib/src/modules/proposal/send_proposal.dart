// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:passaqui/src/modules/auth/login/login_screen.dart';
// import 'package:passaqui/src/modules/home/home_page.dart';
// import 'package:passaqui/src/modules/profile/update-bank-account/update_profile_screen.dart';
// import 'package:passaqui/src/modules/proposal/download_proposal_screen.dart';
// import 'package:passaqui/src/services/auth_service.dart';
// import 'package:passaqui/src/services/preference_service.dart';
// import 'package:passaqui/src/services/proposal_service.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../core/di/service_locator.dart';
// import '../../core/navigation/navigation_handler.dart';
// import '../../shared/widget/appbar.dart';
//
// class SendProposalScreen extends StatefulWidget {
//   static const String route = "/send-proposal";
//
//
//   const SendProposalScreen({super.key});
//
//   @override
//   State<SendProposalScreen> createState() => _SendProposalScreenState();
// }
//
// class _SendProposalScreenState extends State<SendProposalScreen> {
//   late PageController _pageController;
//   final AuthService _authService = DIService().inject<AuthService>();
//   final ProposalService _proposalService = DIService().inject<ProposalService>();
//   final PreferenceService _preferenceService = DIService().inject<PreferenceService>();
//   String userName = '';
//
//   Future<void> loadUserName() async {
//     try {
//       final name = await _authService.getName();
//       setState(() {
//         userName = name ?? ''; // Update the userName variable
//       });
//     } catch (e) {
//       print('Failed to load user name: $e');
//     }
//   }
//
//   Future<void> handleSendProposal() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // final cpf = prefs.getString('cpf') ?? '';
//     final cpf = "01049588479";
//     //final cpf = await _authService.getCpf();
//     final periodo = prefs.getInt('selectedPeriod') ?? 1; // Default to 1 if not found
//     final vlrEmprestimo = prefs.getDouble('vlrEmprestimo') ?? 0.0; // Default to 0.0 if not found
//
//     Map<String, dynamic> responseBody = await _proposalService.sendProposal(cpf, periodo, vlrEmprestimo);
//     print("Resposta da proposta: $responseBody");
//
//     bool hasError = responseBody['HasError'] == true;
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(hasError ? 'Erro ao enviar proposta' : 'Sucesso'),
//           content: Text(hasError ? 'Não foi possível enviar sua proposta. Verifique seus dados e tente novamente' : 'Proposta enviada com sucesso!'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 DIService().inject<NavigationHandler>().navigate(DownloadProposalScreen.route);
//                   if (!hasError) {
//                     //
//                   }
//                 },
//                 child: Text('Prosseguir para baixar proposta'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//
//     @override
//     void initState() {
//       _pageController = PageController();
//       loadUserName();
//       _printSelectedPeriod();
//       super.initState();
//     }
//
//     Future<void> _printSelectedPeriod() async {
//       final prefs = await SharedPreferences.getInstance();
//       final selectedPeriod = prefs.getInt('selectedPeriod');
//       print('Selected Period: $selectedPeriod');
//     }
//
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
//         body: SafeArea(
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       DIService()
//                           .inject<NavigationHandler>()
//                           .navigate(UpdateBankProfileScreen.route);
//                     },
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: SvgPicture.asset(
//                   'assets/images/credit-approved.svg', // Replace with your SVG asset path
//                   height: 300, // Adjust the height as needed
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: const Text(
//                   "Oba! Para dar prosseguimento no processo, basta clicar em enviar proposta!",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                   child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 0),
//                           child: PassaquiButton(
//                             label: "Enviar Proposta",
//                             showArrow: true,
//                             minimumSize: const Size(200, 40),
//                           onTap: () {
//                             handleSendProposal();
//                           },
//                         ),
//                       ),
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passaqui/src/modules/profile/update-bank-account/update_profile_screen.dart';
import 'package:passaqui/src/modules/proposal/download_proposal_screen.dart';
import 'package:passaqui/src/services/auth_service.dart';
import 'package:passaqui/src/services/preference_service.dart';
import 'package:passaqui/src/services/proposal_service.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/di/service_locator.dart';
import '../../core/navigation/navigation_handler.dart';

class SendProposalScreen extends StatefulWidget {
  static const String route = "/send-proposal";

  const SendProposalScreen({Key? key}) : super(key: key);

  @override
  State<SendProposalScreen> createState() => _SendProposalScreenState();
}

class _SendProposalScreenState extends State<SendProposalScreen> {
  late PageController _pageController;
  final AuthService _authService = DIService().inject<AuthService>();
  final ProposalService _proposalService =
      DIService().inject<ProposalService>();
  final PreferenceService _preferenceService =
      DIService().inject<PreferenceService>();
  String userName = '';
  bool isLoading = false;

  Future<void> loadUserName() async {
    try {
      final name = await _authService.getName();
      setState(() {
        userName = name ?? ''; // Update the userName variable
      });
    } catch (e) {
      print('Failed to load user name: $e');
    }
  }

  Future<void> handleSendProposal() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final cpf = prefs.getString('cpf') ?? '';
    // final cpf = "01049588479";
    final cpf = await _authService.getCpf();
    final periodo =
        prefs.getInt('selectedPeriod') ?? 1; // Default to 1 if not found
    final vlrEmprestimo =
        prefs.getDouble('vlrEmprestimo') ?? 0.0; // Default to 0.0 if not found

    Map<String, dynamic> responseBody =
        await _proposalService.sendProposal(cpf, periodo, vlrEmprestimo);

    print('RESPONSE BODY : $responseBody');
    bool hasError = responseBody['HasError'] == true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(hasError ? 'Erro ao enviar proposta' : 'Sucesso'),
          content: Text(hasError
              ? 'Não foi possível enviar sua proposta. Verifique seus dados e tente novamente'
              : 'Proposta enviada com sucesso!'),
          actions: hasError
              ? [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ]
              : [
                  TextButton(
                    onPressed: () {
                      DIService()
                          .inject<NavigationHandler>()
                          .navigate(DownloadProposalScreen.route);
                      if (!hasError) {
                        //
                      }
                    },
                    child: Text('Prosseguir'),
                  ),
                ],
        );
      },
    );

    setState(() {
      isLoading = false; // Hide loading indicator
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    loadUserName();
    _printSelectedPeriod();
    super.initState();
  }

  Future<void> _printSelectedPeriod() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedPeriod = prefs.getInt('selectedPeriod');
    print('Selected Period: $selectedPeriod');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Row(
                //   children: [
                //     IconButton(
                //       icon: const Icon(Icons.arrow_back, color: Colors.white),
                //       onPressed: () {
                //         Navigator.of(context).pop();
                //         DIService().inject<NavigationHandler>()
                //             .navigate(UpdateBankProfileScreen.route);
                //       },
                //     ),
                //   ],
                // ),
                Expanded(
                  child: SvgPicture.asset(
                    'assets/images/credit-approved.svg',
                    // Replace with your SVG asset path
                    height: 300, // Adjust the height as needed
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    "Oba! Para dar prosseguimento no processo, basta clicar em enviar proposta!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: PassaquiButton(
                            label: "Enviar Proposta",
                            showArrow: true,
                            minimumSize: const Size(200, 40),
                            onTap: () {
                              handleSendProposal();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
