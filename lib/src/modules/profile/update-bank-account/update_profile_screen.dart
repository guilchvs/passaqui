import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passaqui/src/modules/profile/profile_screen.dart';
import 'package:passaqui/src/modules/profile/update-bank-account/update_bank_account_controller.dart';
import 'package:passaqui/src/modules/withdraw/welcome/withdraw_welcome_screen.dart';
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

  late TextEditingController cpfInputController;
  late TextEditingController bankInputController;
  late TextEditingController agencyInputController;
  late TextEditingController bankAccountInputController;

  @override
  void initState() {
    super.initState();
    cpfInputController = TextEditingController();
    bankInputController = TextEditingController();
    agencyInputController = TextEditingController();
    bankAccountInputController = TextEditingController();
  }

  @override
  void dispose() {
    cpfInputController.dispose();
    bankInputController.dispose();
    agencyInputController.dispose();
    bankAccountInputController.dispose();
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
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                    DIService()
                        .inject<NavigationHandler>()
                        .navigate(ProfileScreen.route);
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PassaquiTextField(
                    editingController: bankInputController,
                    placeholder: "Digite seu Banco",
                  ),
                  const SizedBox(height: 16),
                  PassaquiTextField(
                    editingController: agencyInputController,
                    placeholder: "Digite sua agência bancária",
                  ),
                  const SizedBox(height: 16),
                  PassaquiTextField(
                    editingController: bankAccountInputController,
                    placeholder: "Digite sua conta do banco",
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: PassaquiButton(
                          label: "Salvar",
                          showArrow: true,
                          minimumSize: const Size(200, 40),
                          onTap: () {
                            DIService()
                                .inject<NavigationHandler>()
                                .navigate(ProfileScreen.route);
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
