// import 'package:flutter/material.dart';
// import '../../../shared/widget/button.dart';
// import '../login/login_screen.dart'; // Adjust the import path as per your project structure
//
// class SuccessScreen extends StatelessWidget {
//   static const String route = "/success";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 32.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start
//             children: [
//               Text(
//                 "Oba! Recebemos seu cadastro!",
//                 textAlign: TextAlign.start, // Aligns text to the start
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 32),
//               Text(
//                 "Enviamos um email de confirmação, consegue checar?",
//                 textAlign: TextAlign.start, // Aligns text to the start
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 40),
//               Center(
//                 child: PassaquiButton(
//                   style: PassaquiButtonStyle.secondary,
//                   centerText: true,
//                   textColor: Colors.black,
//                   label: "Volte à tela de início",
//                   minimumSize: Size(200, 40),
//                   onTap: () {
//                     Navigator.of(context).pushNamed(LoginScreen.route);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passaqui/src/modules/welcome/welcome_screen.dart';
import '../../../shared/widget/button.dart';
import '../login/login_screen.dart'; // Adjust the import path as per your project structure

class SuccessScreen extends StatelessWidget {
  static const String route = "/success";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align children to the start
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
            children: [
              SizedBox(height: 80), // Add some space at the top
              Center(
                child: Image.asset(
                  'assets/images/success_register.png',
                  height: 300, // Adjust the height as needed
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 34),
              Text(
                "Oba! Recebemos seu cadastro!",
                textAlign: TextAlign.start, // Align text to the start
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 32),
              Text(
                "Enviamos um email de confirmação, consegue checar?",
                textAlign: TextAlign.start, // Align text to the start
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: PassaquiButton(
                  style: PassaquiButtonStyle.secondary,
                  centerText: true,
                  textColor: Colors.black,
                  label: "Volte à tela de início",
                  minimumSize: Size(200, 40),
                  onTap: () {
                    Navigator.of(context).pushNamed(WelcomeScreen.route);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

