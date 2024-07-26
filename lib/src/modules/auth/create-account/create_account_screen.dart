import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:date_format_field/date_format_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passaqui/src/modules/welcome/welcome_screen.dart';
import 'package:passaqui/src/services/auth_service.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/text_field.dart';
import 'package:search_cep/search_cep.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import '../success/success_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String route = "/create-account";

  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  List<bool> _fieldErrors = List.generate(15, (_) => false);
  final TextEditingController _dateController = TextEditingController();
  late PageController _pageController;
  int _currentPageIndex = 0;
  late DateTime? date;

  late List<TextEditingController> controllers;
  List<String> labels = [
    "Bem vindo ao PassAqui!\n\nPara começar precisamos de algumas informações. Será rápido e fácil.",
    "Agora nos informe sua senha:",
    "Informe sua senha novamente:",
    "Insira seu CPF no campo abaixo:",
    "Agora informe seu telefone:",
    "Por favor, insira sua data de nascimento",
    "Estamos quase finalizando.\n\nInforme seu e-mail no campo abaixo:",
    "Agora precisamos do seu RG:",
    "Agora entramos na etapa sobre sua residência.",
    "Insira abaixo o nome do logradouro, por favor:",
    "Agora informe o número da sua residência:",
    "Informe (caso exista) o complemento da localização de sua residência:",
    "Por favor confira ou informe o bairro:",
    "Caso nao esteja preenchida nos informe sua Cidade abaixo:",
    "E por ultimo por favor confira ou informe o Estado de sua residencia:"
  ];

  List<String> placeholders = [
    "Digite seu nome completo",
    "Digite sua senha",
    "Digite sua senha novamente",
    "Digite seu CPF",
    "Digite seu telefone",
    "Data nascimento",
    "Digite seu e-mail",
    "Digite seu RG",
    "Digite seu CEP",
    "Digite seu logradouro",
    "Digite seu número",
    "Digite o complemento (opcional)",
    "Digite o bairro",
    "Digite a Cidade",
    "Digite o Estado",
  ];

  final AuthService _authService = AuthService();
  bool showCpfError = false;
  bool showEmailError = false;
  bool showCepError = false;
  bool showError = false; // Flag to track empty field error
  bool _isLoading = false;

  @override
  void initState() {
    _pageController = PageController();
    controllers =
        List.generate(labels.length, (index) => TextEditingController());
    date = null;
    _setDateControllerText();
    _dateController.addListener(_formatDate);
    controllers[8].addListener(_onTextChanged);
    super.initState();
  }

  void _onTextChanged() {
    if (_currentPageIndex == 8 && controllers[8].text.isNotEmpty) {
      _findCEPandFillAddress();
    }
  }

  void _setDateControllerText() {
    if (date != null) {
      _dateController.text = DateFormat('dd/MM/yyyy').format(date!);
    }
  }

  void _formatDate() {
    String text = _dateController.text;
    text = text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length >= 5) {
      text =
          '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4, 8)}';
    } else if (text.length >= 3) {
      text =
          '${text.substring(0, 2)}/${text.substring(2, 4)}${text.length > 4 ? '/' : ''}${text.length > 4 ? text.substring(4) : ''}';
    }
    _dateController.value = _dateController.value.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    controllers.forEach((controller) => controller.dispose());
    _dateController.dispose();
    controllers[8].removeListener(_onTextChanged);
    super.dispose();
  }

  void nextPage() {
    FocusScope.of(context).unfocus();
    if (_currentPageIndex < 8) {
      if (_isFieldValid()) {
        setState(() {
          showCpfError = false;
          showEmailError = false;
          showCepError = false;
          showError = false; // Reset error flag
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPageIndex++;
        });
      } else {
        setState(() {
          showError = true; // Show error for empty field
        });
        return;
      }
    } else {
      if (_isAddressEmpty())
        _registerAccount();
      else {
        print('ops');
      }
    }
  }

  void _validateFields() {
    setState(() {
      for (int i = 8; i <= 14; i++) {
        _fieldErrors[i] = controllers[i].text.isEmpty;
      }
    });
  }

  void previousPage() {
    if (_currentPageIndex > 0) {
      setState(() {
        showCpfError = false;
        showEmailError = false;
        showCepError = false;
        showError = false; // Reset error flag
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPageIndex--;
      });
    }
  }

  void navigateToWelcomeScreen() {
    DIService().inject<NavigationHandler>().navigate(WelcomeScreen.route);
  }

  Future<void> _registerAccount() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authService.register(
        email: controllers[6].text.trim(),
        name: controllers[0].text.trim(),
        password: controllers[1].text.trim(),
        confirmPassword: controllers[2].text.trim(),
        cpf: controllers[3].text.trim(),
        telefone: controllers[4].text.trim(),
        cep: controllers[8].text.trim(),
        logradouro: controllers[9].text.trim(),
        numeroLogradouro: int.tryParse(controllers[10].text.trim()) ?? 0,
        complemento: controllers[11].text.trim(),
        dataNascimento: _formatDateForSaving(date),
        rg: controllers[7].text.trim(),
        bairro: controllers[12].text.trim(),
        cidade: controllers[13].text.trim(),
        estado: controllers[14].text.trim(),
      );

      if (response.statusCode == 200) {
        print('Account registered successfully');
        setState(() {
          _isLoading = false;
        });
        DIService().inject<NavigationHandler>().navigate(SuccessScreen.route);
      } else {
        throw Exception('Failed to register account: ${response.body}');
      }
    } catch (e) {
      print('Error registering account: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatDateForSaving(DateTime? date) {
    try {
      return DateFormat('yyyy-MM-dd').format(date!);
    } catch (e) {
      print('Error formatting date: $e');
      return date as String; // Return original if format cannot be determined
    }
  }

  bool _isFieldValid() {
    if (_currentPageIndex == 1) {
      String password = controllers[1].text.trim();
      print('Password: $password');

      if (password.isNotEmpty &&
          password.length >= 8 &&
          _containsLettersAndNumbers(password)) {
        print('Password is valid');
        setState(() {
          showError = false; // Hide error message
        });
        return true;
      } else {
        setState(() {
          showError = true; // Show error for invalid password
        });
        print('Password is invalid');
        return false;
      }
    } else if (_currentPageIndex == 2) {
      String password = controllers[1].text.trim();
      String confirmPassword = controllers[2].text.trim();
      if (password.isNotEmpty && confirmPassword.isNotEmpty) {
        if (password == confirmPassword) {
          return true;
        } else {
          setState(() {
            showError = true; // Show error for non-matching passwords
          });
          return false;
        }
      } else {
        return false;
      }
    } else if (_currentPageIndex == 3) {
      bool isCpfValid = CPFValidator.isValid(controllers[3].text.trim());
      if (!isCpfValid) {
        setState(() {
          showCpfError = true;
        });
        return false;
      }
      return true;
    } else if (_currentPageIndex == 4) {
      String telefone = controllers[4].text.trim();
      if (telefone.length == 11) {
        return true;
      } else {
        setState(() {
          showError = true; // Show error for invalid phone number
        });
        return false;
      }
    } else if (_currentPageIndex == 6) {
      bool isEmailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(controllers[6].text.trim());
      if (!isEmailValid) {
        setState(() {
          showEmailError = true;
        });
        return false;
      }
      return true;
    } else if (_currentPageIndex == 8 && controllers[8].text.isNotEmpty) {
      _findCEPandFillAddress();
    } else if (_currentPageIndex != 11) {
      if (controllers[_currentPageIndex].text.isNotEmpty) {
        return true;
      } else {
        setState(() {
          showError = true; // Show error for empty fields
        });
        return false;
      }
    }
    return true;
  }

  bool _isAddressEmpty() {
      setState(() {
        _fieldErrors[8] = controllers[8].text.isEmpty;
        _fieldErrors[9] = controllers[9].text.isEmpty;
        _fieldErrors[10] = controllers[10].text.isEmpty;
        _fieldErrors[12] = controllers[12].text.isEmpty;
        _fieldErrors[13] = controllers[13].text.isEmpty;
        _fieldErrors[14] = controllers[14].text.isEmpty;
      });

    return controllers[8].text.isNotEmpty &&
        controllers[9].text.isNotEmpty &&
        controllers[10].text.isNotEmpty &&
        controllers[12].text.isNotEmpty &&
        controllers[13].text.isNotEmpty &&
        controllers[14].text.isNotEmpty;
  }



  bool _containsLettersAndNumbers(String value) {
    final hasLetters = RegExp(r'[a-zA-Z]').hasMatch(value);
    final hasNumbers = RegExp(r'\d').hasMatch(value);

    print('Password contains letters: $hasLetters');
    print('Password contains numbers: $hasNumbers');

    return hasLetters && hasNumbers;
  }

  Future<void> _findCEPandFillAddress() async {
    String _cepAtual = controllers[8].text.trim();
    final viaCepSearchCep = ViaCepSearchCep();
    final infoCepJSON = await viaCepSearchCep.searchInfoByCep(cep: _cepAtual);
    String parsedjson = infoCepJSON.toString();

    if (parsedjson.contains('Right')) {
      final values = parsedjson
          .split(",")
          .map((x) => x.trim())
          .where((element) => element.isNotEmpty)
          .toList();

      final logradouro = values[1].replaceFirst('logradouro: ', '');
      final bairro = values[3].replaceFirst('bairro: ', '');
      final cidade = values[4].replaceFirst('localidade: ', '');
      final uf = values[5].replaceFirst('uf: ', '');

      setState(() {
        controllers[9].text = logradouro;
        controllers[12].text = bairro;
        controllers[13].text = cidade;
        controllers[14].text = uf;
        showCepError = false; // Hide error if CEP is valid
      });
    } else {
      setState(() {
        showCepError = true;
        controllers[9].text = "";
        controllers[12].text = "";
        controllers[13].text = "";
        controllers[14].text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            !_isLoading ? Colors.transparent : Colors.black.withOpacity(0.5),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          color: const Color(0xFFA8CA4B),
          onPressed: previousPage,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            color: const Color(0xFFA8CA4B),
            onPressed: navigateToWelcomeScreen,
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: (_currentPageIndex + 1) / labels.length,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(const Color(0xFFA8CA4B)),
                    backgroundColor: Colors.grey[50],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        kBottomNavigationBarHeight,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: labels.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 28),
                              if (labels[index]
                                  .startsWith("Bem vindo ao PassAqui!")) ...[
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Bem vindo ao PassAqui!',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text:
                                            '\n\nPara começar precisamos de algumas informações. Será rápido e fácil.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ] else ...[
                                Text(
                                  labels[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                              SizedBox(height: 28),
                              if (index == 5) ...[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: _buildDateField(),
                                ),
                                SizedBox(height: 16),
                                if (showError &&
                                    controllers[index].text.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      'Este campo não pode ficar vazio',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ] else if (index == 8) ...[
                                PassaquiTextField(
                                  placeholder: placeholders[index],
                                  editingController: controllers[8],
                                  keyBoardType: TextInputType.number,
                                  isVisible: true,
                                  showVisibility: false,
                                  placeholderColor: Colors.grey,
                                  textColor: Colors.black,
                                ),
                                if (_fieldErrors[8])
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0, left: 20),
                                    child: Text(
                                      "Esse campo é obrigatório",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                SizedBox(height: _fieldErrors[8] ? 0 : 4),
                                PassaquiTextField(
                                  placeholder: placeholders[9], // Placeholder for the additional field
                                  editingController: controllers[9], // Adjust if needed
                                  keyBoardType: TextInputType.text,
                                  isVisible: true,
                                  showVisibility: false,
                                  placeholderColor: Colors.grey,
                                  textColor: Colors.black,
                                ),
                                if (_fieldErrors[9])
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0, left: 20),
                                    child: Text(
                                      "Esse campo é obrigatório",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                SizedBox(height: _fieldErrors[9] ? 0 : 4),
                                PassaquiTextField(
                                  placeholder: placeholders[10], // Placeholder for the additional field
                                  editingController: controllers[10], // Adjust if needed
                                  keyBoardType: TextInputType.number,
                                  isVisible: true,
                                  showVisibility: false,
                                  placeholderColor: Colors.grey,
                                  textColor: Colors.black,
                                ),
                                if (_fieldErrors[10])
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0, left: 20),
                                    child: Text(
                                      "Esse campo é obrigatório",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                SizedBox(height: _fieldErrors[10] ? 0 : 4),
                                SizedBox(height: 4),
                                PassaquiTextField(
                                  placeholder: placeholders[11], // Placeholder for the additional field
                                  editingController: controllers[11], // Adjust if needed
                                  keyBoardType: TextInputType.text,
                                  isVisible: true,
                                  showVisibility: false,
                                  placeholderColor: Colors.grey,
                                  textColor: Colors.black,
                                ),
                                SizedBox(height: 4),
                                PassaquiTextField(
                                  placeholder: placeholders[12], // Placeholder for the additional field
                                  editingController: controllers[12], // Adjust if needed
                                  keyBoardType: TextInputType.text,
                                  isVisible: true,
                                  showVisibility: false,
                                  placeholderColor: Colors.grey,
                                  textColor: Colors.black,
                                ),
                                if (_fieldErrors[12])
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0, left: 20),
                                    child: Text(
                                      "Esse campo é obrigatório",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                SizedBox(height: _fieldErrors[12] ? 0 : 4),
                                PassaquiTextField(
                                  placeholder: placeholders[13], // Placeholder for the additional field
                                  editingController: controllers[13], // Adjust if needed
                                  keyBoardType: TextInputType.text,
                                  isVisible: true,
                                  showVisibility: false,
                                  placeholderColor: Colors.grey,
                                  textColor: Colors.black,
                                ),
                                if (_fieldErrors[13])
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0, left: 20),
                                    child: Text(
                                      "Esse campo é obrigatório",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                SizedBox(height: _fieldErrors[13] ? 0 : 4),
                                PassaquiTextField(
                                  placeholder: placeholders[14],
                                  editingController: controllers[14],
                                  keyBoardType: TextInputType.text,
                                  isVisible: true,
                                  showVisibility: false,
                                  placeholderColor: Colors.grey,
                                  textColor: Colors.black,
                                ),
                                if (_fieldErrors[14])
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0, left: 20),
                                    child: Text(
                                      "Esse campo é obrigatório",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                              ]
                              else ...[
                                PassaquiTextField(
                                  placeholder: placeholders[index],
                                  editingController: controllers[index],
                                  keyBoardType: index == 3 ||
                                          index == 4 ||
                                          index == 7 ||
                                          index == 8 ||
                                          index == 10
                                      ? TextInputType.number
                                      : TextInputType.text,
                                  isVisible: index != 1 && index != 2,
                                  showVisibility: index == 1 || index == 2,
                                  placeholderColor: Colors.grey,
                                  textColor: Colors.black,
                                ),
                                if ((index == 1 || index == 2) &&
                                        controllers[index].text.isNotEmpty &&
                                        controllers[index].text.length < 8 ||
                                    (index == 1 || index == 2) &&
                                        controllers[index].text.isNotEmpty &&
                                        !_containsLettersAndNumbers(
                                            controllers[index].text))
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      'A senha deve ter no mínimo 8 caracteres e conter letras e números',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                if (index == 3 && showCpfError)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 4),
                                    child: Text(
                                      'CPF inválido',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                if (index == 6 && showEmailError)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 4),
                                    child: Text(
                                      'Email inválido',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                if (index == 8 && showCepError)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      'CEP não encontrado. Clique em prosseguir para continuar',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                if (index == 2 &&
                                    showError &&
                                    controllers[1].text.isNotEmpty &&
                                    controllers[2].text.isNotEmpty &&
                                    controllers[1].text != controllers[2].text)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      'As senhas não correspondem',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                if (showError &&
                                    controllers[index].text.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 4),
                                    child: Text(
                                      'Este campo não pode ficar vazio',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                if (index == 4 &&
                                    showError &&
                                    controllers[4].text.isNotEmpty &&
                                    controllers[4].text.length != 11)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 4),
                                    child: Text(
                                      'O telefone deve ter exatamente 11 dígitos',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).viewInsets.bottom),
                            ],
                          ),
                        );
                      },
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PassaquiButton(
                  // label: _currentPageIndex == labels.length - 1
                  label: _currentPageIndex == 8
                      ? 'Concluir'
                      : 'Próximo',
                  onTap: nextPage,
                  showArrow: true,
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return DateFormatField(
        type: DateFormatType.type2,
        controller: _dateController,
        addCalendar: false,
        decoration: const InputDecoration(
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFA8CA4B),
              width: 2.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFFA8CA4B), width: 1.0),
          ),
        ),
        onComplete: (date) {
          try {
            _dateController.text = DateFormat('dd/MM/yyyy').format(date!);
            controllers[5].text = _dateController.text;
            setState(() {
              this.date = date;
            });
          } catch (e) {
            // Handle invalid date format
            setState(() {
              showError = true;
            });
          }
        });
  }
}
