import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/hire/installment/hire_installment_screen.dart';
import 'package:passaqui/src/services/auth_service.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/card.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:passaqui/src/utils/format_cpf.dart';

class HireCpfScreen extends StatefulWidget {
  static const String route = "/hire-cpf";

  const HireCpfScreen({super.key});

  @override
  State<HireCpfScreen> createState() => _HireCpfScreenState();
}

class _HireCpfScreenState extends State<HireCpfScreen> {
  final AuthService _authService = DIService().inject<AuthService>();
  late String? cpf;

  @override
  void initState() {
    super.initState();
    _initializeCpf();
  }

  void _initializeCpf() async {
    cpf = await _authService.getCpf();
    setState(() {});
  }

  void _showCpfMismatchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("CPF não cadastrado"),
        content: Text(
          "O CPF informado não corresponde ao CPF cadastrado.",
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(showBackButton: true, showLogo: false),
      backgroundColor: Color.fromRGBO(18, 96, 73, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Antecipação Saque Aniversario",
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/fgts.svg"),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Uma forma simples e fácil de dar um alívio nas suas despesas.",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
              child: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 50,
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 32, left: 16, right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PassaquiButton(
                            label: "Realizar consulta",
                            showArrow: true,
                            onTap: () {
                              DIService().inject<NavigationHandler>().navigate(
                                  HireInstallmentScreen.route,
                                  arguments: {'cpf': cpf as String});
                            },
                          )
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  left: 16,
                  right: 16,
                  child: PassaquiCard(
                    backgroundColor: Colors.white,
                    height: 100,
                    content: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Confirme seu CPF: ",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: 200, // Adjust width as needed
                            child: Text(
                              formatCpf(cpf as String),
                              style: GoogleFonts.roboto(
                                color: Color(0xFF136048),
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ))
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HireCpfScreen(),
  ));
}
