import 'package:flutter/material.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/withdraw/steps/withdraw_step_screen.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class WithdrawWelcomeScreen extends StatefulWidget {
  static const String route = "/withdraw";

  const WithdrawWelcomeScreen({super.key});

  @override
  State<WithdrawWelcomeScreen> createState() => _WithdrawWelcomeScreenState();
}

class _WithdrawWelcomeScreenState extends State<WithdrawWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              children: [
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height /
                          3, // Set height to 1/3 of screen height
                      width: MediaQuery.of(context)
                          .size
                          .width, // Set width to full screen width
                      child: Image.asset(
                        "assets/images/homem.png",
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Como realizar\n",
                            style: TextStyle(
                              fontSize: 22,
                              color: Color.fromRGBO(18, 96, 73, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight
                                  .w700, // Weight 700 for "Como realizar"
                              height: 1.5, // Line height for "Como realizar"
                            ),
                          ),
                          TextSpan(
                            text: "a contratação?",
                            style: TextStyle(
                              fontSize: 22,
                              color: Color.fromRGBO(18, 96, 73, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight
                                  .w400, // Weight 400 for "a contratação"
                              height: 1.5, // Line height for "a contratação"
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Text(
                    "Para simular e antecipar seu Saque-Aniversário você precisa ter habilitado a modalidade e autorizado nossa instituição a consultar o saldo pelo aplicativo do FGTS.",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: Color(0xFF1E1E1E)),
                    textAlign: TextAlign.left, // Text alignment left
                  ),
                ),
                const SizedBox(height: 40),
                const PassaquiButton(
                  label: "Habilitar Saque-Aniversário",
                  textColor: Color.fromRGBO(18, 96, 73, 1),
                  borderColor: Color.fromRGBO(18, 96, 73, 1),
                  style: PassaquiButtonStyle.secondary,
                ),
                const SizedBox(height: 20),
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
        ),
      ),
    );
  }
}
