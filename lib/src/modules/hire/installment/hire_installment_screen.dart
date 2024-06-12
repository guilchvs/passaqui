import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/card.dart';

class HireInstallmentScreen extends StatefulWidget {
  static const String route = "/hire-installment";

  const HireInstallmentScreen({Key? key}) : super(key: key);

  @override
  State<HireInstallmentScreen> createState() => _HireInstallmentScreenState();
}

class _HireInstallmentScreenState extends State<HireInstallmentScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedPeriod = '1x'; // Default selected period

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PassaquiAppBar(showBackButton: true, showLogo: false),
      backgroundColor: Color.fromRGBO(18, 96, 73, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Simulação de crédito",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 22),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  top: MediaQuery.of(context).size.height / 5,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: PassaquiCard(
                      height: 240,
                      backgroundColor: Colors.white,
                      content: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Quanto você deseja antecipar?",
                              style: GoogleFonts.inter(
                                color: Color(0xFF515151),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'R\$',
                                  style: GoogleFonts.inter(
                                    color: Color(0xFF136048),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Center(
                                    child: TextFormField(
                                      controller: _amountController,
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                      ],
                                      style: GoogleFonts.inter(
                                        color: Color(0xFF136048),
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '0,00',
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        hintStyle: GoogleFonts.inter(
                                          color: Color(0xFF136048).withOpacity(0.3),
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "min: R\$ 200,00",
                                  style: GoogleFonts.inter(
                                    color: Color(0xFF515151),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "max: R\$ 4000,00",
                                  style: GoogleFonts.inter(
                                    color: Color(0xFF515151),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 300,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 32.0),
                            child: Text(
                              "Escolha o número de períodos",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: DropdownButton<String>(
                              value: _selectedPeriod,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedPeriod = newValue!;
                                });
                              },
                              items: <String>[
                                '1x',
                                '2x',
                                '3x',
                                '4x R\$ 1.125,00 (juros de 1,79% a.m.)'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                      color: Color(0xFF136048),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 64),
                          Center(
                            child: PassaquiButton(
                              label: 'Simular',
                              style: PassaquiButtonStyle.primary,
                              showArrow: true,
                              onTap: () {
                                // Add your simulation logic here
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HireInstallmentScreen(),
  ));
}

