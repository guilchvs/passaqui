import 'package:flutter/material.dart';
import 'package:passaqui/src/shared/widget/button.dart';

import '../login/login_screen.dart'; // Adjust the import path as per your project structure

class SuccessScreen extends StatelessWidget {
  static const String route = "/success";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Oba! Recebemos seu cadastro!\n\nEnviamos um email de confirmação, consegue checar?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            PassaquiButton(
              label: "Ir para Login",
              minimumSize: Size(200, 40),
              onTap: () {
                Navigator.of(context).pushNamed(LoginScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
