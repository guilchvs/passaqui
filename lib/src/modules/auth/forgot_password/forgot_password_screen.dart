import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/auth/forgot_password/success/forgot_password_success.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String route = "/forgot-password";

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

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
                    SvgPicture.asset("assets/images/email_password.svg"),
                    const SizedBox(height: 24,),
                    const Text(
                      "Esqueceu a senha?",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF136048),
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16,),
                    const Text(
                      "Insira seu endereço de e-mail e enviaremos as instruções para redefinição de senha.",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF484C4F),
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40,),
                    PassaquiTextField(
                      editingController: _emailController,
                      label: "Email",
                    ),
                    const SizedBox(
                      height: 56,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12
                      ),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          const Flexible(
                              flex: 2,
                              child: PassaquiButton(
                                label: "Voltar",
                              )
                          ),
                          const SizedBox(width: 16,),
                          Flexible(
                              flex: 4,
                              child: PassaquiButton(
                                label: "Continuar",
                                onTap: (){
                                  DIService().inject<NavigationHandler>().navigate(ForgotPasswordSuccessScreen.route);
                                },
                              )
                          ),
                        ],
                      ),
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
