import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passaqui/src/modules/profile/profile_screen.dart';
import 'package:passaqui/src/modules/profile/profile_service.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/utils/format_cpf.dart';
import 'package:passaqui/src/utils/format_phone_number.dart';
import '../../core/di/service_locator.dart';
import '../../core/navigation/navigation_handler.dart';
import '../../services/auth_service.dart';
import '../../shared/widget/bottom_sheet.dart';
import '../../shared/widget/date_format_field.dart';
import '../../shared/widget/text_field.dart';

class EditProfileScreen extends StatefulWidget {
  static const String route = "/edit-profile";

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AuthService _authService = DIService().inject<AuthService>();
  final AccountService _accountService = DIService().inject<AccountService>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _numeroLogradouroController =
  TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  final TextEditingController _dataNascimentoController =
  TextEditingController();
  int? _id;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    _id = await _authService.getId();
    final name = await _authService.getName();
    final email = await _authService.getEmail();
    final cpf = await _authService.getCpf();
    final rg = await _authService.getRg();
    final telefone = await _authService.getTelefone();
    final cep = await _authService.getCep();
    final logradouro = await _authService.getLogradouro();
    final complemento = await _authService.getComplemento();
    final numeroLogradouro = await _authService.getNumeroLogradouro();
    final bairro = await _authService.getBairro();
    final cidade = await _authService.getCidade();
    final uf = await _authService.getUf();
    final dataNascimento = await _authService.getDataNascimento();

    // Format the date
    String formattedDate = '';
    if (dataNascimento != null && dataNascimento.isNotEmpty) {
      try {
        DateTime dateTime = DateTime.parse(dataNascimento);
        formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
      } catch (e) {
        // Handle any parsing errors
        print('Error parsing date: $e');
      }
    }

    setState(() {
      _nameController.text = name ?? '';
      _emailController.text = email ?? '';
      _cpfController.text = cpf ?? '';
      _rgController.text = rg ?? '';
      _telefoneController.text = telefone ?? '';
      _cepController.text = cep ?? '';
      _logradouroController.text = logradouro ?? '';
      _complementoController.text = complemento ?? '';
      _numeroLogradouroController.text = numeroLogradouro ?? '';
      _bairroController.text = bairro ?? '';
      _cidadeController.text = cidade ?? '';
      _ufController.text = uf ?? '';
      _dataNascimentoController.text = formattedDate;
    });
  }

  Future<bool> _saveProfile() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final cpf = _cpfController.text;
    final rg = _rgController.text;
    final telefone = _telefoneController.text;
    final cep = _cepController.text;
    final logradouro = _logradouroController.text;
    final complemento = _complementoController.text;
    final numeroLogradouro = int.tryParse(_numeroLogradouroController.text) ?? 0;
    final dataNascimento = _dataNascimentoController.text; // Ensure the date format is correct
    final bairro = _bairroController.text;
    final cidade = _cidadeController.text;
    final estado = _ufController.text;

    String? formattedDateForApi;
    if (dataNascimento.isNotEmpty) {
      try {
        DateTime dateTime = DateFormat('dd/MM/yyyy').parse(dataNascimento);
        formattedDateForApi = DateFormat('yyyy-MM-dd').format(dateTime);
        print(formattedDateForApi);
      } catch (e) {
        // Handle any parsing errors
        print('Error parsing date for API: $e');
      }
    }

    try {
      final success = await _accountService.updateAccount(
        id: this._id as int,
        email: email,
        name: name,
        cpf: cpf,
        telefone: telefone,
        cep: cep,
        logradouro: logradouro,
        numeroLogradouro: numeroLogradouro,
        complemento: complemento,
        dataNascimento: formattedDateForApi ?? '',
        rg: rg,
        bairro: bairro,
        cidade: cidade,
        estado: estado,
      );

      if (success) {
        await _authService.setEmail(email);
        await _authService.setNome(name);
        await _authService.setCpf(cpf);
        await _authService.setTelefone(telefone);
        await _authService.setCep(cep);
        await _authService.setLogradouro(logradouro);
        await _authService.setNumeroLogradouro(numeroLogradouro.toString());
        await _authService.setComplemento(complemento);
        await _authService.setDataNascimento(formattedDateForApi ?? '');
        await _authService.setRg(rg);
        await _authService.setBairro(bairro);
        await _authService.setCidade(cidade);
        await _authService.setUf(estado);
        return true;
      } else {
        return false;
        print('Profile update failed');
      }


    } catch (e) {
      print('Failed to update profile: $e');
      return false; // Indicate failure
    }
  }

  void _onUpdateProfileButtonPressed() {
    final isNameEmpty = _nameController.text.isEmpty;
    final isEmailEmpty = _emailController.text.isEmpty;
    final isCpfEmpty = _cpfController.text.isEmpty;
    final isRgEmpty = _rgController.text.isEmpty;
    final isTelefoneEmpty = _telefoneController.text.isEmpty;
    final isCepEmpty = _cepController.text.isEmpty;
    final isLogradouroEmpty = _logradouroController.text.isEmpty;
    final isNumeroLogradouroEmpty = _numeroLogradouroController.text.isEmpty;
    final isBairroEmpty = _bairroController.text.isEmpty;
    final isCidadeEmpty = _cidadeController.text.isEmpty;
    final isUfEmpty = _ufController.text.isEmpty;

    if (isNameEmpty ||
        isEmailEmpty ||
        isCpfEmpty ||
        isRgEmpty ||
        isTelefoneEmpty ||
        isCepEmpty ||
        isLogradouroEmpty ||
        isNumeroLogradouroEmpty ||
        isBairroEmpty ||
        isCidadeEmpty ||
        isUfEmpty) {
      // Show an error message if any required field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Campos obrigatórios'),
          content: const Text('Por favor, preencha todos os campos obrigatórios.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // All required fields are filled; show the confirmation sheet
      _showConfirmationSheet();
    }
  }


  void _showConfirmationSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                Text(
                  'Nome: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _nameController.text,
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'E-mail: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _emailController.text,
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Data de nascimento: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _dataNascimentoController.text,
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'CPF: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  formatCpf(_cpfController.text),
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'RG: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _rgController.text,
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Telefone: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  formatPhoneNumber(_telefoneController.text),
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Cep: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _cepController.text,
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Logradouro: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _logradouroController.text,
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Numero: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _numeroLogradouroController.text,
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Complemento: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _complementoController.text,
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Bairro: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _bairroController.text,
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Cidade: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _cidadeController.text,
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'UF: ',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _ufController.text,
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 18),
          ],
        ),
        onTap: () async {
          bool success = await _saveProfile();
          if (success) {
            Navigator.pop(context); // Close bottom sheet
            DIService().inject<NavigationHandler>().navigate(ProfileScreen.route);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Erro"),
                  content: const Text("Não foi possível atualizar o perfil. Tente novamente."),
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
        textOnTap: 'Salvar e continuar',
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(
        showBackButton: true,
        showLogo: false,
      ),
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Editar dados",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              PassaquiTextField(
                placeholder: "Nome",
                editingController: _nameController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              PassaquiTextField(
                placeholder: "E-mail",
                editingController: _emailController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: DateFormatField(
                  type: DateFormatType.type2,
                  controller: _dataNascimentoController,
                  addCalendar: false,
                  textStyle: const TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFA8CA4B),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFA8CA4B), width: 1.0),
                    ),
                  ),
                  onComplete: (date) {},
                ),
              ),
              PassaquiTextField(
                placeholder: "CPF",
                editingController: _cpfController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              PassaquiTextField(
                placeholder: "RG",
                editingController: _rgController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              PassaquiTextField(
                placeholder: "Telefone",
                editingController: _telefoneController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              PassaquiTextField(
                placeholder: "CEP",
                editingController: _cepController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              PassaquiTextField(
                placeholder: "Logradouro",
                editingController: _logradouroController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              PassaquiTextField(
                placeholder: "Número logradouro",
                editingController: _numeroLogradouroController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              PassaquiTextField(
                placeholder: "Complemento",
                editingController: _complementoController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              PassaquiTextField(
                placeholder: "Bairro",
                editingController: _bairroController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              PassaquiTextField(
                placeholder: "Cidade",
                editingController: _cidadeController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              PassaquiTextField(
                placeholder: "UF",
                editingController: _ufController,
                keyBoardType: TextInputType.text,
                isVisible: true,
                showVisibility: false,
                placeholderColor: Colors.grey,
                textColor: Colors.white,
              ),
              const SizedBox(height: 24),
              Center(
                child: PassaquiButton(
                  // onTap: _showConfirmationSheet,
                  onTap: _onUpdateProfileButtonPressed,
                  label: 'Atualizar dados',
                  centerText: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
