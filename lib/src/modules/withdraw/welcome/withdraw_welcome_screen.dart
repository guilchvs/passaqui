import 'package:flutter/material.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/withdraw/steps/withdraw_step_screen.dart';
import 'package:passaqui/src/shared/widget/button.dart';

import '../../home/home_page.dart';

class WithdrawWelcomeScreen extends StatefulWidget {
  static const String route = "/withdraw";

  const WithdrawWelcomeScreen({Key? key}) : super(key: key);

  @override
  _WithdrawWelcomeScreenState createState() => _WithdrawWelcomeScreenState();
}

class _WithdrawWelcomeScreenState extends State<WithdrawWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Image.asset(
                    "assets/images/homem.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 64,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Color(0xFFA8CA4B),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.white, // White chevron color
                        size: 24, // Adjust size if necessary
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Como realizar\n",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color.fromRGBO(18, 96, 73, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: "a contratação?",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color.fromRGBO(18, 96, 73, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      "Para simular e antecipar seu Saque-Aniversário você precisa ter habilitado a modalidade e autorizado nossa instituição a consultar o saldo pelo aplicativo do FGTS.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: Color(0xFF1E1E1E),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 40),
                  PassaquiButton(
                    label: "Habilitar Saque-Aniversário",
                    textColor: Color.fromRGBO(18, 96, 73, 1),
                    borderColor: Color.fromRGBO(18, 96, 73, 1),
                    style: PassaquiButtonStyle.secondary,
                    onTap: () {
                      DIService()
                          .inject<NavigationHandler>()
                          .navigate(HomeScreen.route);
                    }
                  ),
                  SizedBox(height: 20),
                  PassaquiButton(
                    style: PassaquiButtonStyle.primary,
                    showArrow: true,
                    label: "Veja como habilitar",
                    borderColor: Colors.black,
                    onTap: () {
                      DIService()
                          .inject<NavigationHandler>()
                          .navigate(WithdrawStepsScreen.route);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
