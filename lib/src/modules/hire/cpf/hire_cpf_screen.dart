import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/card.dart';

class HireCpfScreen extends StatefulWidget {
  static const String route = "/hire-cpf";

  const HireCpfScreen({super.key});

  @override
  State<HireCpfScreen> createState() => _HireCpfScreenState();
}

class _HireCpfScreenState extends State<HireCpfScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(),
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
          const SizedBox(height: 24,),
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
                            bottom: 32,
                            left: 16, right: 16
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PassaquiButton(
                                label: "Realizar consulta",
                                onTap: (){},
                              )
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                      left: 16,
                      right: 16,
                      child: PassaquiCard(
                        height: 100,
                        content: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Informe seu CPF: ",
                                style: GoogleFonts.roboto(
                                  color: Color(0xFF515151),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                "000.000.000-00",
                                style: GoogleFonts.roboto(
                                  color: Color(0xFF136048),
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              )
              // Stack(
              //   children: [
              //     Positioned(
              //     //   left: 0,
              //     //   right: 0,
              //     // bottom: 0,
              //     // top: 100,
              //       child: Container(
              //         height: 100,
              //         width: double.infinity,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(12),
              //             topRight: Radius.circular(12),
              //           )
              //         ),
              //       ),
              //     )
              //   ],
              // )
              )
        ],
      ),
    );
  }
}
