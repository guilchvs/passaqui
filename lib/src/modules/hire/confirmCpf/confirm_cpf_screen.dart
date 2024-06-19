import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import '../../../shared/widget/appbar.dart';
import '../../../shared/widget/button.dart';
import '../confirmEmail/hire_confirm_email.dart';

class HireConfirmCpfScreen extends StatefulWidget {
  static const String route = "/hire-confirm-cpf";
  final String? cpf;

  const HireConfirmCpfScreen({Key? key, this.cpf}) : super(key: key);

  @override
  State<HireConfirmCpfScreen> createState() => _HireConfirmCpfScreenState();
}

class _HireConfirmCpfScreenState extends State<HireConfirmCpfScreen> {
  late TextEditingController _firstPartController;
  late TextEditingController _secondPartController;
  late TextEditingController _thirdPartController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;

  @override
  void initState() {
    super.initState();
    _firstPartController = TextEditingController();
    _secondPartController = TextEditingController();
    _thirdPartController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstPartController.dispose();
    _secondPartController.dispose();
    _thirdPartController.dispose();
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    super.dispose();
  }

  void _handleTextChange(TextEditingController controller, FocusNode currentFocus, FocusNode? nextFocus, [FocusNode? previousFocus]) {
    String text = controller.text;
    if (text.isNotEmpty && nextFocus != null) {
      // Move focus to the next field
      FocusScope.of(context).requestFocus(nextFocus);
    } else if (text.isEmpty && previousFocus != null) {
      // Move focus to the previous field when text is deleted
      FocusScope.of(context).requestFocus(previousFocus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(
        showLogo: false,
        showBackButton: true,
      ),
      backgroundColor: Color.fromRGBO(18, 96, 73, 1),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 16),
                child: Text(
                  'Informações básicas',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Center(
                        child: Text(
                          'Confirme os 3 primeiros dígitos do seu CPF:',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF515151),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildInputField(_firstPartController, _firstFocusNode, _secondFocusNode),
                          SizedBox(width: 2),
                          _buildInputField(_secondPartController, _secondFocusNode, _thirdFocusNode, _firstFocusNode),
                          SizedBox(width: 2),
                          _buildInputField(_thirdPartController, _thirdFocusNode, null, _secondFocusNode),
                          SizedBox(width: 2),
                          _buildNumberText(widget.cpf != null && widget.cpf!.length >= 6 ? '.${widget.cpf!.substring(3, 6)}' : '.'),
                          SizedBox(width: 2),
                          _buildNumberText(widget.cpf != null && widget.cpf!.length >= 9 ? '.${widget.cpf!.substring(6, 9)}' : '.'),
                          SizedBox(width: 2),
                          _buildNumberText(widget.cpf != null && widget.cpf!.length >= 11 ? '-${widget.cpf!.substring(9)}' : '-'),
                        ],
                      ),
                      SizedBox(height: 48),
                      Center(
                        child: PassaquiButton(
                          label: 'Confirmar',
                          centerText: true,
                          borderRadius: 50,
                          style: PassaquiButtonStyle.primary,
                          onTap: () {
                            DIService().inject<NavigationHandler>().navigate(
                              HireConfirmEmailScreen.route,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberText(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        color: Color(0xFF515151),
        fontSize: 40,
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, FocusNode focusNode, FocusNode? nextFocus, [FocusNode? previousFocus]) {
    return Container(
      width: 50,
      height: 60,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (_) {
          _handleTextChange(controller, focusNode, nextFocus, previousFocus);
        },
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          counterText: "",
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
