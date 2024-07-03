import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ProposalController {
  bool isLoading = false;

  void setIsLoading(bool value) {
    isLoading = value;
  }

  Widget getWidgetBasedOnItemReturn(String itemReturn) {
    switch (itemReturn) {
      case 'teste':
        setIsLoading(true);
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                      letterSpacing: .8),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          ],
        );
      case 'resultado 2':
        setIsLoading(false);
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        );
      default:
        return Container(); // Otro widget para el caso por defecto
    }
  }
}
