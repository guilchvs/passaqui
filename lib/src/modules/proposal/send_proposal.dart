import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/modules/profile/update-bank-account/update_profile_screen.dart';
import 'package:passaqui/src/services/auth_service.dart';
import 'package:passaqui/src/shared/widget/button.dart';

import '../../core/di/service_locator.dart';
import '../../core/navigation/navigation_handler.dart';
import '../../shared/widget/appbar.dart';

class SendProposalScreen extends StatefulWidget {
  static const String route = "/send-proposal";

  const SendProposalScreen({super.key});

  @override
  State<SendProposalScreen> createState() => _SendProposalScreenState();
}

class _SendProposalScreenState extends State<SendProposalScreen> {
  late PageController _pageController;
  late AuthService _authService;
  String userName = '';

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

  @override
  void initState() {
    _pageController = PageController();
    loadUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                    DIService()
                        .inject<NavigationHandler>()
                        .navigate(UpdateBankProfileScreen.route);
                  },
                ),
              ],
            ),
            Expanded(
              child: SvgPicture.asset(
                'assets/images/credit-approved.svg', // Replace with your SVG asset path
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            DIService()
                                .inject<NavigationHandler>()
                                .navigate(HomeScreen.route);
                          },
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
