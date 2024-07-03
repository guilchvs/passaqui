import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/modules/profile/profile_service.dart';
import 'package:passaqui/src/modules/proposal/controller/proposal_controller.dart';
import 'package:passaqui/src/services/account/account_service.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class ConsultProposalScreen extends StatefulWidget {
  static const String route = "/consult-proposal";

  const ConsultProposalScreen({super.key});

  @override
  State<ConsultProposalScreen> createState() => ConsultProposalScreenState();
}

class ConsultProposalScreenState extends State<ConsultProposalScreen> {
  // late Timer _timer;
  final ProposalController _controller = ProposalController();
  late bool isLoading;
  static const String itemReturn = "teste";

  late final AccountService _accountService =
      DIService().inject<AccountService>();

  @override
  void initState() {
    super.initState();
    isLoading = _controller.isLoading;
    // TODO: descomentar assim que a API estiver OK
    // _accountService.consultProposal(
    //     codigoProposta: 'codigoProposta', codigoOperacao: 'codigoOperacao');
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    DIService()
                        .inject<NavigationHandler>()
                        .navigate(HomeScreen.route);
                  },
                ),
              ],
            ),
            Expanded(
              child: _controller.getWidgetBasedOnItemReturn(itemReturn),
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
                          label: "Consultar Proposta",
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
