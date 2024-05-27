import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/link.dart';
import 'package:passaqui/src/shared/widget/text_field.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String route = "/create-account";

  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {

  late TextEditingController userInputController;
  late TextEditingController cpfInputController;
  late TextEditingController telInputController;
  late TextEditingController emailInputController;
  late TextEditingController cepInputController;
  late TextEditingController logInputController;
  late TextEditingController numInputController;
  late TextEditingController complInputController;

  @override
  void initState() {
    userInputController = TextEditingController();
    cpfInputController = TextEditingController();
    telInputController = TextEditingController();
    emailInputController = TextEditingController();
    cepInputController = TextEditingController();
    logInputController = TextEditingController();
    numInputController = TextEditingController();
    complInputController = TextEditingController();
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
                    const SizedBox(height: 64,),
                    SvgPicture.asset("assets/images/create_account.svg"),
                    const SizedBox(height: 20,),
                    const Text(
                      "Acessar minha conta",
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF136048),
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 40,),
                    PassaquiTextField(
                      editingController: userInputController,
                      label: "Nome completo",
                    ),
                    const SizedBox(height: 16,),
                    PassaquiTextField(
                      editingController: cpfInputController,
                      label: "CPF",
                    ),
                    const SizedBox(height: 16,),
                    PassaquiTextField(
                      editingController: telInputController,
                      label: "Telefone",
                    ),
                    const SizedBox(height: 16,),
                    PassaquiTextField(
                      editingController: emailInputController,
                      label: "E-mail",
                    ),
                    const SizedBox(height: 16,),
                    PassaquiTextField(
                      editingController: cepInputController,
                      label: "CEP",
                    ),
                    const SizedBox(height: 16,),
                    PassaquiTextField(
                      editingController: logInputController,
                      label: "Logradouro",
                    ),
                    const SizedBox(height: 16,),
                    PassaquiTextField(
                      editingController: numInputController,
                      label: "Numero",
                    ),
                    const SizedBox(height: 16,),
                    PassaquiTextField(
                      editingController: complInputController,
                      label: "Complemento",
                    ),
                    const SizedBox(height: 56,),
                    const PassaquiButton(
                      label: "Continuar",
                      minimumSize: Size(200, 40),
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      width: double.infinity,
                      height: 1.4,
                      color: const Color(0xFF4D5D71),
                    ),
                    const SizedBox(height: 16,),
                     PassaquiLink(
                      label: "Já tem conta? Faça login",
                      onTap: (){
                        DIService().inject<NavigationHandler>().pop();
                      },
                    ),
                    SizedBox(
                      height:MediaQuery.of(context).viewPadding.bottom + 16
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
