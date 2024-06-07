import 'package:flutter/material.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/hire/steps/hire_step_screen.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/card.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe3e1e1),
      body: Stack(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            height: 280,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28, top: 70),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset("assets/images/ellipse.png",
                            height: 40, width: 40),
                        const SizedBox(width: 10),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: 'Olá,',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: ' nome',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 28.0),
                          child: Image.asset("assets/images/notification_bell.png",
                            height: 34, width: 34),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
        Positioned(
          top: 160,
          left: 16,
          right: 16,
          child: PassaquiCard(
            height: 160,
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset("assets/images/logo_passaqui_round.png"),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Antecipe seu FGTS",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Uma forma simples e fácil de dar alívio nas suas despesas",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        PassaquiButton(
                          label: "Solicite agora",
                          showArrow: true,
                          style: PassaquiButtonStyle.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 36,
                          width: 250,
                          onTap: () {
                            DIService()
                                .inject<NavigationHandler>()
                                .navigate(HireStepsScreen.route);
                          },
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
