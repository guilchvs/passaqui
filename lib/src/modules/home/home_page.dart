import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/hire/steps/hire_step_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/card.dart';
import 'package:passaqui/src/shared/widget/hide_text.dart';

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
      backgroundColor: Color(0xFFe3e1e1),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Image.asset(
                      "assets/images/logo_passaqui_hor_1.png",
                      height: 130,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 4),
                  child: Text(
                    "Olá, João Silva",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 24, bottom: 16),
              child: Text(
                "Meus serviços",
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: const Color(0xFF515151),
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  DIService()
                      .inject<NavigationHandler>()
                      .navigate(HireStepsScreen.route);
                },
                child: PassaquiCard(
                    height: 112,
                    content: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/ic_emprestimo.svg"),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "FGTS",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF515151)),
                                ),
                                Text(
                                  "Uma forma simples e fácil de dar alívio nas suas despesas",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF515151)),
                                ),
                              ],
                            ),
                          )),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 24, bottom: 16),
              child: Text(
                "Benefícios exclusivos",
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Color(0xFF515151),
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PassaquiCard(
                  height: 112,
                  content: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/images/ic_gift.svg"),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Benefícios",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF515151)),
                              ),
                              Text(
                                "Ganhe descontos e cashback na sua próxima compra",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF515151)),
                              ),
                            ],
                          ),
                        )),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                  )),
            ),
          ],
        ))
      ]),
    );
  }
}
