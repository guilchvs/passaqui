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
                  height: 40,
                ),
                const Text(
                  "Como realizar a contratação?",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF1E1E1E),
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 32,
                ),
                SvgPicture.asset('assets/images/passaqui_logo.svg', height: 200),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    right: 20, 
                    left: 20, 
                  ),
                  child: Text(
                    "Para simular e antecipar seu saque aniversário, você precisa ter habilitado a modalidade e autorizado nosso banco a consultar seu saldo no aplicativo do FGTS.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Raleway',
                      color: Color(0xFF1E1E1E)
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 120),
                const PassaquiButton(
                  label: "Veja como autorizar"
                ),
                const Text("Ou"),
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
