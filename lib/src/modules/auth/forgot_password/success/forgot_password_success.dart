import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class ForgotPasswordSuccessScreen extends StatefulWidget {
  static const String route = "/forgot-password-success";

  const ForgotPasswordSuccessScreen({super.key});

  @override
  State<ForgotPasswordSuccessScreen> createState() => _ForgotPasswordSuccessScreenState();
}

class _ForgotPasswordSuccessScreenState extends State<ForgotPasswordSuccessScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26)),
                color: Color(0xFFF0F0F0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    SvgPicture.asset("assets/images/email_sended.svg"),
                    const SizedBox(height: 24,),
                    const Text(
                      "Email enviado!",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF136048),
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16,),
                    const Text(
                      "Não consegue encontra-lo? verifique se há um e-mail de contato@email.com.br na sua pasta de spam ou clique em  Reenviar e-mail",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF484C4F),
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(
                      height: 56,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12
                      ),
                      child: PassaquiButton(
                        label: "Continuar",
                      )
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
