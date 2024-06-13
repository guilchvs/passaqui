// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_fonts/google_fonts.dart';
// import 'package:passaqui/src/shared/widget/appbar.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:passaqui/src/shared/widget/card.dart';
//
// import '../../../services/auth_service.dart'; // Import your AuthService
//
// class HireInstallmentScreen extends StatefulWidget {
//   static const String route = "/hire-installment";
//   final String? cpf;
//
//   const HireInstallmentScreen({Key? key, this.cpf}) : super(key: key);
//
//   @override
//   State<HireInstallmentScreen> createState() => _HireInstallmentScreenState();
// }
//
// class _InstallmentOption {
//   final int numberOfValues;
//   final double VlrRepasse;
//   final double VlrJuros;
//
//   _InstallmentOption({
//     required this.numberOfValues,
//     required this.VlrRepasse,
//     required this.VlrJuros,
//   });
//
//   @override
//   String toString() {
//     int displayValue = numberOfValues + 1;
//     return '${displayValue}  x de R\$${VlrRepasse.toStringAsFixed(2)} - Juros de ${VlrJuros.toStringAsFixed(2)}%';
//   }
// }
//
// class _HireInstallmentScreenState extends State<HireInstallmentScreen> {
//   final TextEditingController _amountController = TextEditingController();
//   String _selectedPeriod = ''; // Default selected period
//   bool _isLoading = false;
//   final AuthService _authService = AuthService(); // Instance of your AuthService
//   List<_InstallmentOption> _installmentOptions = []; // List to store installment options
//
//   Future<void> _simulateApiCall(String cpf, double amount) async {
//     setState(() {
//       _isLoading = true; // Set loading state while waiting for API response
//     });
//
//     final baseUrl = 'http://passcash-api-hml.us-east-1.elasticbeanstalk.com'; // Replace with your API base URL
//     final token = await _authService.getToken(); // Retrieve JWT token
//     final cpf = '01052320414';
//     final url = Uri.parse('$baseUrl/api/ApiMaster/fazerSimulacaoFGTS?cpf=$cpf&vlrEmprestimo=$amount');
//
//     try {
//       final response = await http.post(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $token', // Include Bearer token in headers
//         },
//       );
//
//       if (response.statusCode == 200) {
//         // Handle successful API response here
//         final jsonResponse = jsonDecode(response.body);
//
//         List<dynamic> simulacoes = jsonResponse['Simulacoes'] ?? [];
//
//         List<_InstallmentOption> options = [];
//         for (var simulacao in simulacoes) {
//           List<dynamic> simulacaoParcelas = simulacao['SimulacaoParcelas'] ?? [];
//           for (var parcela in simulacaoParcelas) {
//             options.add(_InstallmentOption(
//               numberOfValues: parcela['Periodo'] ?? 0,
//               VlrRepasse: (parcela['VlrRepasse'] ?? 0.0).toDouble(),
//               VlrJuros: (parcela['VlrJuros'] ?? 0.0).toDouble(),
//             ));
//           }
//         }
//
//         setState(() {
//           _installmentOptions = options;
//           _selectedPeriod = options.isNotEmpty ? options.first.toString() : '';
//         });
//       } else {
//         // Handle other status codes here
//         print('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle exceptions
//       print('Error: $e');
//     } finally {
//       setState(() {
//         _isLoading = false; // Reset loading state
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PassaquiAppBar(showBackButton: true, showLogo: false),
//       backgroundColor: Color.fromRGBO(18, 96, 73, 1),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 24),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               "Simulação de crédito",
//               style: GoogleFonts.inter(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(height: 22),
//           Expanded(
//             child: Stack(
//               children: [
//                 Positioned.fill(
//                   top: MediaQuery.of(context).size.height / 5,
//                   child: Container(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     child: PassaquiCard(
//                       height: 240,
//                       backgroundColor: Colors.white,
//                       content: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Quanto você deseja antecipar?",
//                               style: GoogleFonts.inter(
//                                 color: Color(0xFF515151),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'R\$',
//                                   style: GoogleFonts.inter(
//                                     color: Color(0xFF136048),
//                                     fontSize: 26,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 SizedBox(width: 4),
//                                 Expanded(
//                                   child: Center(
//                                     child: TextFormField(
//                                       controller: _amountController,
//                                       keyboardType: TextInputType.numberWithOptions(decimal: true),
//                                       inputFormatters: [
//                                         FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
//                                       ],
//                                       style: GoogleFonts.inter(
//                                         color: Color(0xFF136048),
//                                         fontSize: 26,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText: '0,00',
//                                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                                         hintStyle: GoogleFonts.inter(
//                                           color: Color(0xFF136048).withOpacity(0.3),
//                                           fontSize: 26,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       // Trigger API call on editing complete
//                                       onEditingComplete: () {
//                                         final amount = double.tryParse(_amountController.text.replaceAll(',', '.'));
//                                         if (amount != null) {
//                                           _simulateApiCall(widget.cpf ?? '', amount);
//                                         } else {
//                                           // Handle invalid input
//                                           print('Invalid amount entered');
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 16),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "min: R\$ 200,00",
//                                   style: GoogleFonts.inter(
//                                     color: Color(0xFF515151),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   "max: R\$ 4000,00",
//                                   style: GoogleFonts.inter(
//                                     color: Color(0xFF515151),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 300,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 32.0),
//                             child: Text(
//                               "Escolha o número de períodos",
//                               style: GoogleFonts.inter(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Center(
//                             child: DropdownButton<String>(
//                               value: _selectedPeriod,
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   _selectedPeriod = newValue!;
//                                 });
//                               },
//                               items: _installmentOptions.map((option) {
//                                 return DropdownMenuItem<String>(
//                                   value: option.toString(),
//                                   child: Text(
//                                     option.toString(),
//                                     style: GoogleFonts.inter(
//                                       color: Color(0xFF136048),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                           const SizedBox(height: 64),
//                           Center(
//                             child: PassaquiButton(
//                               label: 'Simular',
//                               style: PassaquiButtonStyle.primary,
//                               showArrow: true,
//                               onTap: () {
//                                 final amount = double.tryParse(_amountController.text.replaceAll(',', '.'));
//                                 if (amount != null) {
//                                   _simulateApiCall(widget.cpf ?? '', amount);
//                                 } else {
//                                   // Handle invalid input
//                                   print('Invalid amount entered');
//                                 }
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (_isLoading)
//                   Container(
//                     color: Colors.black.withOpacity(0.5),
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/card.dart';

import '../../../services/auth_service.dart'; // Import your AuthService

class HireInstallmentScreen extends StatefulWidget {
  static const String route = "/hire-installment";
  final String? cpf;

  const HireInstallmentScreen({Key? key, this.cpf}) : super(key: key);

  @override
  State<HireInstallmentScreen> createState() => _HireInstallmentScreenState();
}

class _InstallmentOption {
  final int numberOfValues;
  final double VlrRepasse;
  final double VlrJuros;

  _InstallmentOption({
    required this.numberOfValues,
    required this.VlrRepasse,
    required this.VlrJuros,
  });

  @override
  String toString() {
    int displayValue = numberOfValues + 1;
    return '$displayValue x de ${VlrRepasse.toStringAsFixed(2)} - Juros de ${VlrJuros.toStringAsFixed(2)}%';
  }
}

class _HireInstallmentScreenState extends State<HireInstallmentScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedPeriod = ''; // Default selected period
  bool _isLoading = false;
  final AuthService _authService = AuthService(); // Instance of your AuthService
  List<_InstallmentOption> _installmentOptions = []; // List to store installment options

  Future<void> _simulateApiCall(String cpf, double amount) async {
    setState(() {
      _isLoading = true; // Set loading state while waiting for API response
    });

    final baseUrl = 'http://passcash-api-hml.us-east-1.elasticbeanstalk.com'; // Replace with your API base URL
    final token = await _authService.getToken(); // Retrieve JWT token
    final cpf = '01052320414';
    final url = Uri.parse('$baseUrl/api/ApiMaster/fazerSimulacaoFGTS?cpf=$cpf&vlrEmprestimo=$amount');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Include Bearer token in headers
        },
      );

      if (response.statusCode == 200) {
        // Handle successful API response here
        final jsonResponse = jsonDecode(response.body);

        List<dynamic> simulacoes = jsonResponse['Simulacoes'] ?? [];

        List<_InstallmentOption> options = [];
        for (var simulacao in simulacoes) {
          List<dynamic> simulacaoParcelas = simulacao['SimulacaoParcelas'] ?? [];
          for (var parcela in simulacaoParcelas) {
            options.add(_InstallmentOption(
              numberOfValues: parcela['Periodo'] != null ? parcela['Periodo'] + 1 : 0, // Increment numberOfValues by 1
              VlrRepasse: (parcela['VlrRepasse'] ?? 0.0).toDouble(),
              VlrJuros: (parcela['VlrJuros'] ?? 0.0).toDouble(),
            ));
          }
        }

        setState(() {
          _installmentOptions = options;
          _selectedPeriod = options.isNotEmpty ? options.first.toString() : '';
        });
      } else {
        // Handle other status codes here
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    }
  }

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
                                    child: FocusScope(
                                      // Wrap with FocusScope
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
                                        // Trigger API call on editing complete
                                        onEditingComplete: () {
                                          final amount = double.tryParse(_amountController.text.replaceAll(',', '.'));
                                          if (amount != null) {
                                            _simulateApiCall(widget.cpf ?? '', amount);
                                            // Unfocus keyboard after API call
                                            FocusScope.of(context).unfocus();
                                          } else {
                                            // Handle invalid input
                                            print('Invalid amount entered');
                                          }
                                        },
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
                              items: _installmentOptions.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option.toString(),
                                  child: Text(
                                    option.toString(),
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
                                final amount = double.tryParse(_amountController.text.replaceAll(',', '.'));
                                if (amount != null) {
                                  _simulateApiCall(widget.cpf ?? '', amount);
                                  // Unfocus keyboard after API call
                                  FocusScope.of(context).unfocus();
                                } else {
                                  // Handle invalid input
                                  print('Invalid amount entered');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
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
