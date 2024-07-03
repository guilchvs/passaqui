import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/modules/proposal/controller/proposal_controller.dart';
import 'package:passaqui/src/modules/proposal/finish_proposal_screen.dart';
import 'package:passaqui/src/services/account/account_service.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class ConsultProposalScreen extends StatefulWidget {
  static const String route = "/consult-proposal";

  const ConsultProposalScreen({super.key});

  @override
  State<ConsultProposalScreen> createState() => ConsultProposalScreenState();
}

class ConsultProposalScreenState extends State<ConsultProposalScreen> {
  late Timer _timer;
  final ProposalController _controller = ProposalController();
  late bool isLoading;
  ValueNotifier<String> itemReturn = ValueNotifier('success');

  void setTimer15Seconds() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      print(itemReturn.value);
      setState(() {
        itemReturn = ValueNotifier('');
      });
      print(itemReturn.value);
      timer.cancel();
    });
  }

  late final AccountService _accountService =
      DIService().inject<AccountService>();

  void fetching() {
    // print(itemReturn.value);
    // setState(() {
    //   itemReturn.value = 'loading';
    // });
    // setTimer15Seconds();
    DIService()
        .inject<NavigationHandler>()
        .navigate(ConsultProposalScreen.route);
  }

  void setSuccess() {
    // print(itemReturn.value);
    // setState(() {
    //   itemReturn.value = 'success';
    // });
    DIService()
        .inject<NavigationHandler>()
        .navigate(FinishProposalScreen.route);
    setTimer15Seconds();
  }

  void setError() {
    // print(itemReturn.value);
    // setState(() {
    //   itemReturn.value = 'error';
    // });
    DIService()
        .inject<NavigationHandler>()
        .navigate(ConsultProposalScreen.route);
    setTimer15Seconds();
  }

  @override
  void initState() {
    super.initState();
    isLoading = _controller.isLoading;
    itemReturn.value = itemReturn.value;
    if (itemReturn.value == 'loading') {
      setTimer15Seconds();
    }
    itemReturn.addListener(() {
      setState(() {
        switch (itemReturn.value) {
          case 'loading':
            itemReturn.value = itemReturn.value;
            break;
          case 'success':
            itemReturn.value = 'success';
            break;
          case 'error':
            itemReturn.value = 'error';
            break;
          default:
            itemReturn.value = '';
            break;
        }
      });
    });
    // TODO: descomentar assim que a API estiver OK
    // _accountService.consultProposal(
    //     codigoProposta: 'codigoProposta', codigoOperacao: 'codigoOperacao');
  }

  @override
  void dispose() {
    // _timer.cancel();
    itemReturn.removeListener(() {});
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
              child: _controller.getWidgetBasedOnItemReturn(
                  itemReturn: itemReturn.value,
                  fetching: fetching,
                  setSuccess: setSuccess,
                  setError: setError),
            ),
          ],
        ),
      ),
    );
  }
}
