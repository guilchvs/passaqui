import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/modules/proposal/controller/proposal_controller.dart';
import 'package:passaqui/src/services/account/account_service.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class FinishProposalScreen extends StatefulWidget {
  static const String route = "/finish-proposal";

  const FinishProposalScreen({super.key});

  @override
  State<FinishProposalScreen> createState() => FinishProposalScreenState();
}

class FinishProposalScreenState extends State<FinishProposalScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
            const Expanded(
              child: Text(
                "FINIHSHED!!!",
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
                          label: "Finalizar Proposta",
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
