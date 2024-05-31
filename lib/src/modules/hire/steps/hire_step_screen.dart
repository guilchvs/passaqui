import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/core/app_theme.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/hire/cpf/hire_cpf_screen.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/modules/withdraw/welcome/withdraw_welcome_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/text_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HireStepsScreen extends StatefulWidget {
  static const String route = "/hire-how-to";

  const HireStepsScreen({super.key});

  @override
  State<HireStepsScreen> createState() => _HireStepsScreenState();
}

class _HireStepsScreenState extends State<HireStepsScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  List<HireStepItem> steps = [
    const HireStepItem(
      title: r"Chegou o saque aniversário Pa$$aqui",
      image: "assets/images/simulation.svg",
      description:
          "Uma forma simples e fácil de dar um alívio nas suas despesas e em qualquer outro momento",
      showButton: false,
    ),
    const HireStepItem(
      title: "Simule o quanto você precisa de forma rápida e fácil",
      image: "assets/images/simulation.svg",
      description:
          "Simule o valor que precisa e a melhor forma de pagamento para o seu bolso",
      showButton: false,
    ),
    const HireStepItem(
      title: "Receba o crédito pessoal em sua conta ",
      image: "assets/images/receive-money.svg",
      description: "Dinheiro no seu bolso e sem burocracias",
      showButton: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(showBackButton: true, showLogo: false),
      backgroundColor: Color.fromRGBO(18, 96, 73, 1),
      body: Stack(
        children: [
              PageView.builder(
                  controller: _pageController,
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    return steps[index];
                  }),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).viewPadding.bottom + 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                    controller: _pageController,  // PageController
                    count:  steps.length,
                    effect:  WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      activeDotColor: Color(0xFFA8CA4B),
                      dotColor: Colors.white
                    ),  // your preferred effect
                    onDotClicked: (index){},
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}

class HireStepItem extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final bool showButton;

  const HireStepItem(
      {this.showButton = false,
      required this.title,
      required this.image,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  width: double.infinity,
                  child: SvgPicture.asset(image,
                      alignment: Alignment.centerRight))),
          Expanded(
              child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    title,
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32,),
                showButton ?
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40
                  ),
                  child: PassaquiButton(
                    label: "Continuar",
                    onTap: (){
                      DIService().inject<NavigationHandler>().navigate(HireCpfScreen.route);
                    },
                    isLight: false,
                  ),
                ): const SizedBox()
              ],
            ),
          ))
        ],
      ),
    );
  }
}
