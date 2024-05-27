import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/withdraw/steps/withdraw_step_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
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
      appBar: const PassaquiAppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Como realizar a contratação?",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF136048),
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 24,
                ),
                SvgPicture.asset('assets/images/passaqui_logo.svg'),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  "Para simular e antecipar seu saque aniversário, você precisa ter habilitado a modalidade e autorizado nosso banco a consultar seu saldo no aplicativo do FGTS.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Raleway',
                    color: Color(0xFF1E1E1E)
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                PassaquiButton(
                  label: "Veja como autorizar"
                ),
                Text("Ou"),
                PassaquiButton(
                    label: "Habilitar Saque-Aniversário",
                  onTap: (){
                    DIService().inject<NavigationHandler>().navigate(WithdrawStepsScreen.route);
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
