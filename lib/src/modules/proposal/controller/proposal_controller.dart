import 'dart:async';
import 'package:flutter/material.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class ProposalController {
  bool isLoading = true;
  late Timer _timer;

  void setIsLoading(bool value) {
    isLoading = value;
  }

  Widget getWidgetBasedOnItemReturn({
    required String itemReturn,
    required Function? fetching,
    required Function? setSuccess,
    required Function? setError,
  }) {
    switch (itemReturn) {
      case 'loading':
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Aguarde enquanto\n consultamos sua proposta!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .8,
                  ),
                ),
              ],
            ),
          ],
        );
      case 'success':
        return Column(
          children: [
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Sua Proposta foi criada com sucesso!\n Baixe o documento e leia atentamente! \n \n Após ler, clique em FInalizar Proposta',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
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
                        onTap: () {
                          setSuccess!();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      case 'error':
        return Column(
          children: [
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Houve algum erro,\n tente novamente!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
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
                        label: "Tentar Novamente",
                        showArrow: true,
                        onTap: () {
                          setError!();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      default:
        return Column(
          children: [
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Não conseguimos encontrar \n sua proposta, Clique em \nconsultar novamente!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
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
                        label: "Consultar Novamente",
                        showArrow: true,
                        onTap: () {
                          setError!();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
    }
  }
}
