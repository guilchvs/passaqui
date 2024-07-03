import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/modules/profile/profile_screen.dart';
import 'package:passaqui/src/modules/profile/profile_service.dart';
import 'package:passaqui/src/modules/profile/update-bank-account/update_bank_account_controller.dart';
import 'package:passaqui/src/modules/proposal/send_proposal.dart';
import 'package:passaqui/src/modules/withdraw/welcome/withdraw_welcome_screen.dart';
import 'package:passaqui/src/services/auth_service.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/bottom_sheet.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/text_field.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';

class UpdateBankProfileScreen extends StatefulWidget {
  static const String route = "/editar-dados-bancarios";

  const UpdateBankProfileScreen({super.key});

  @override
  State<UpdateBankProfileScreen> createState() =>
      _UpdateBankProfileScreenState();
}

class _UpdateBankProfileScreenState extends State<UpdateBankProfileScreen> {
  late UpdateBankAccountController _updateBankProfileController;
  final AuthService _authService = DIService().inject<AuthService>();
  final AccountService _accountService = DIService().inject<AccountService>();
  late String? cpf;

  late TextEditingController bankInputController;
  late TextEditingController agencyInputController;
  late TextEditingController agencyDigitInputController;
  late TextEditingController bankAccountInputController;
  late TextEditingController bankAccountDigitInputController;

  bool isFormValid() {
    // Validar se os campos estão preenchidos corretamente
    return bankInputController.text.isNotEmpty &&
        agencyInputController.text.isNotEmpty &&
        agencyDigitInputController.text.isNotEmpty &&
        bankAccountInputController.text.isNotEmpty &&
        bankAccountDigitInputController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    bankInputController = TextEditingController();
    agencyInputController = TextEditingController();
    agencyDigitInputController = TextEditingController();
    bankAccountInputController = TextEditingController();
    bankAccountDigitInputController = TextEditingController();
    // isFormValid();
  }

  @override
  void dispose() {
    bankInputController.dispose();
    agencyInputController.dispose();
    agencyDigitInputController.dispose();
    bankAccountInputController.dispose();
    bankAccountDigitInputController.dispose();
    super.dispose();
  }

  void _initializeCpf() async {
    cpf = await _authService.getCpf();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const PassaquiAppBar(showBackButton: true, showLogo: false),
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                    DIService()
                        .inject<NavigationHandler>()
                        .navigate(HomeScreen.route);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Editar Dados Bancários',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 56),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PassaquiTextField(
                    keyBoardType: TextInputType.number,
                    editingController: bankInputController,
                    placeholder: "Digite seu Banco",
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: PassaquiTextField(
                          editingController: agencyInputController,
                          placeholder: "Agência",
                          keyBoardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 150,
                        child: PassaquiTextField(
                          editingController: agencyDigitInputController,
                          placeholder: "Dígito",
                          keyBoardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: PassaquiTextField(
                          editingController: bankAccountInputController,
                          placeholder: "Conta",
                          keyBoardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 150,
                        child: PassaquiTextField(
                          editingController: bankAccountDigitInputController,
                          placeholder: "Dígito",
                          keyBoardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
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
                        disabled: true,
                        label: "Continuar",
                        showArrow: true,
                        minimumSize: const Size(200, 40),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (context) => CustomBottomSheet(
                              title: 'Confirme os dados',
                              buttonStyle: PassaquiButtonStyle.invertedPrimary,
                              background: PassaquiBottomSheetStyle.primary,
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Text(
                                        'Banco: ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        bankInputController.text,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Text(
                                        'Agência: ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${agencyInputController.text}-${agencyDigitInputController.text}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Text(
                                        'Conta: ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${bankAccountInputController.text}-${bankAccountDigitInputController.text}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 44),
                                ],
                              ),
                              onTap: () {
                                DIService()
                                    .inject<NavigationHandler>()
                                    .navigate(SendProposalScreen.route);
                              },
                              textOnTap: 'Salvar e continuar',
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
