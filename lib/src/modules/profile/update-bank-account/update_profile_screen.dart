import 'package:brazilian_banks/brazilian_banks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/modules/profile/profile_service.dart';
import 'package:passaqui/src/modules/profile/update-bank-account/update_bank_account_controller.dart';
import 'package:passaqui/src/modules/proposal/send_proposal.dart';
import 'package:passaqui/src/services/auth_service.dart';
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
  late List<BrasilApiBanks> banks = [];

  late TextEditingController bankInputController;
  late TextEditingController agencyInputController;
  late TextEditingController agencyDigitInputController;
  late TextEditingController bankAccountInputController;
  late TextEditingController bankAccountDigitInputController;

  final FocusNode bankInputFocusNode = FocusNode();

  bool _isFormValid() {
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
    _initializeCpf();
    _fetchBanks();
  }

  @override
  void dispose() {
    bankInputController.dispose();
    agencyInputController.dispose();
    agencyDigitInputController.dispose();
    bankAccountInputController.dispose();
    bankAccountDigitInputController.dispose();
    bankInputFocusNode.dispose();
    super.dispose();
  }

  void _initializeCpf() async {
    cpf = await _authService.getCpf();
    setState(() {});
  }

  void _fetchBanks() async {
    try {
      List<BrasilApiBanks> fetchedBanks =
          await _accountService.getBrazilianBanksList();
      setState(() {
        banks = fetchedBanks.where((bank) => bank.code != null).toList();
      });
    } catch (e) {
      //
    }
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: TypeAheadFormField<BrasilApiBanks>(
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: bankInputController,
                          focusNode: bankInputFocusNode,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: "Digite seu Banco",
                              filled: true,
                              fillColor: Colors.transparent,
                              border: InputBorder.none,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFA8CA4B),
                                  width: 2.0,
                                ),
                              ),
                              hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.zero),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 16,
                          ),
                          onTap: () {
                            bankInputController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: bankInputController.text.length,
                            );
                          }),
                      suggestionsCallback: (pattern) {
                        return banks.where((bank) =>
                            (bank.fullName
                                    ?.toLowerCase()
                                    .contains(pattern.toLowerCase()) ??
                                false) ||
                            bank.code.toString().contains(pattern));
                      },
                      itemBuilder: (context, bank) {
                        return ListTile(
                            title: Text('${bank.code} - ${bank.fullName}',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                )));
                      },
                      onSuggestionSelected: (bank) {
                        bankInputController.text =
                            '${bank.code} - ${bank.fullName}';
                      },
                      noItemsFoundBuilder: (context) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Nenhum banco encontrado.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
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
                          if (bankInputController.text.isEmpty ||
                              agencyInputController.text.isEmpty ||
                              bankAccountInputController.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Erro"),
                                  content: const Text(
                                      "Todos os campos são obrigatórios."),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (context) => CustomBottomSheet(
                                title: 'Confirme os dados',
                                buttonStyle:
                                    PassaquiButtonStyle.invertedPrimary,
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
                                        Flexible(
                                          child: Text(
                                            bankInputController.text,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          
                                          ),
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
                                          agencyDigitInputController
                                                  .text.isEmpty
                                              ? '${agencyInputController.text}'
                                              : '${agencyInputController.text}-${agencyDigitInputController.text}',
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
                                          bankAccountDigitInputController
                                                  .text.isEmpty
                                              ? '${bankAccountInputController.text}'
                                              : '${bankAccountInputController.text}-${bankAccountDigitInputController.text}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 44),
                                  ],
                                ),
                                onTap: () async {
                                  try {
                                    int bankCode = int.tryParse(
                                            bankInputController.text
                                                .split(' - ')[0]
                                                .trim()) ??
                                        0;
                                    String agency = agencyInputController.text;
                                    String agencyDigit =
                                        agencyDigitInputController.text;
                                    String bankAccount =
                                        bankAccountInputController.text;
                                    String bankAccountDigit =
                                        bankAccountDigitInputController.text;

                                    if (agency.isEmpty || bankAccount.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Erro"),
                                            content: const Text(
                                                "Os campos agência e banco são obrigatórios."),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text("OK"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return;
                                    }

                                    // Print inputs for debugging
                                    print('Bank Code: $bankCode');
                                    print('Agency: $agency');
                                    print('Agency Digit: $agencyDigit');
                                    print('Bank Account: $bankAccount');
                                    print(
                                        'Bank Account Digit: $bankAccountDigit');
                                    print('CPF: $cpf');

                                    var response =
                                        await _accountService.saveBankAccount(
                                      bankCode: bankCode,
                                      bankAccount: bankAccount,
                                      bankAccountDigit: bankAccountDigit,
                                      agency: agency,
                                      agencyDigit: agencyDigit,
                                      cpf: cpf as String,
                                    );

                                    if (response.statusCode == 200) {
                                      DIService()
                                          .inject<NavigationHandler>()
                                          .navigate(SendProposalScreen.route);
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Erro"),
                                            content: const Text(
                                                "Não foi possível cadastrar os dados bancários. Tente novamente"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text("OK"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  } catch (e) {
                                    print('Exception caught: $e');
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Erro"),
                                          content: const Text(
                                              "Ocorreu um erro ao processar os dados. Por favor, verifique os campos e tente novamente."),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text("OK"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                textOnTap: 'Salvar e continuar'
                              ),
                            );
                          }
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
