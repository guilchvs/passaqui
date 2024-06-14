import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/core/app_theme.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/modules/withdraw/welcome/withdraw_welcome_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/text_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HireConfirmCpfScreen extends StatefulWidget {
  static const String route = "/hire-confirm-cpf";
  final String? cpf;

  const HireConfirmCpfScreen({Key? key, this.cpf}) : super(key: key);

  @override
  State<HireConfirmCpfScreen> createState() => _HireConfirmCpfScreenState();
}

class _HireConfirmCpfScreenState extends State<HireConfirmCpfScreen> {
  @override
  void initState() {
    super.initState();
    print('CPF: ${widget.cpf}');
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Center(
                              child: Text(
                                  'Confirme os 3 primeiros dígitos do seu CPF:',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF515151),
                                      fontSize: 16))),
                        ],
                      )))
            ],
          ),
        ],
      ),
    );
  }
}
