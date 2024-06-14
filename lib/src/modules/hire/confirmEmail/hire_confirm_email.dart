// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:passaqui/src/shared/widget/appbar.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
//
// class HireConfirmEmailScreen extends StatefulWidget {
//   static const String route = "/hire-confirm-email";
//
//   const HireConfirmEmailScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HireConfirmEmailScreen> createState() =>
//       _HireConfirmEmailScreenState();
// }
//
// class _HireConfirmEmailScreenState extends State<HireConfirmEmailScreen> {
//   bool useOtherEmail = false; // Track the state of the radio buttons
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const PassaquiAppBar(
//         showLogo: false,
//         showBackButton: true,
//       ),
//       backgroundColor: Color.fromRGBO(18, 96, 73, 1),
//       body: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 24.0, top: 16),
//                 child: Text(
//                   'Informações de contato',
//                   style: GoogleFonts.roboto(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//               Expanded(
//                 child: Container(
//                   color: Colors.white,
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 16),
//                       Center(
//                         child: Text(
//                           'Email atual',
//                           style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xFF515151),
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 36),
//                       _buildRadioOption('jo***se@email.com'),
//                       _buildRadioOption('Usar outro email'),
//                       SizedBox(height: 34),
//                       Center(
//                         child: PassaquiButton(
//                           label: 'Confirmar',
//                           centerText: true,
//                           borderRadius: 50,
//                           style: PassaquiButtonStyle.primary,
//                           onTap: () {
//                             // Handle button tap
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNumberText(String text) {
//     return Text(
//       text,
//       style: GoogleFonts.roboto(
//         fontWeight: FontWeight.w400,
//         color: Color(0xFF515151),
//         fontSize: 40,
//       ),
//     );
//   }
//
//   Widget _buildInputField(TextEditingController controller) {
//     return Container(
//       width: 26,
//       height: 40,
//       child: TextField(
//         controller: controller,
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         style: GoogleFonts.roboto(
//           fontWeight: FontWeight.w400,
//           color: Color(0xFF515151),
//           fontSize: 16,
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Color(0xFFF2F2F2),
//           counterText: "",
//           border: OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRadioOption(String label) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           useOtherEmail = label == 'Usar outro email';
//         });
//       },
//       child: Row(
//         children: [
//           Radio(
//             value: label,
//             groupValue: useOtherEmail ? 'Usar outro email' : 'jo***se@email.com',
//             onChanged: (value) {
//               setState(() {
//                 useOtherEmail = value == 'Usar outro email';
//               });
//             },
//             activeColor: Colors.green, // Selected color
//           ),
//           Text(
//             label,
//             style: GoogleFonts.roboto(
//               fontWeight: FontWeight.w500,
//               color: Color(0xFF515151),
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class HireConfirmEmailScreen extends StatefulWidget {
  static const String route = "/hire-confirm-email";

  const HireConfirmEmailScreen({Key? key}) : super(key: key);

  @override
  State<HireConfirmEmailScreen> createState() =>
      _HireConfirmEmailScreenState();
}

class _HireConfirmEmailScreenState extends State<HireConfirmEmailScreen> {
  bool useOtherEmail = false; // Track the state of the radio buttons

  @override
  void initState() {
    super.initState();
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
                  'Informações de contato',
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
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0), // Adjust left padding as needed
                        child: Text(
                          'Email atual',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF515151),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 46),
                      _buildRadioOption('jo***se@email.com'),
                      SizedBox(height: 26),
                      _buildRadioOption('Usar outro email'),
                      SizedBox(height: 34),
                      Center(
                        child: PassaquiButton(
                          label: 'Confirmar',
                          centerText: true,
                          borderRadius: 50,
                          style: PassaquiButtonStyle.primary,
                          onTap: () {
                            // Handle button tap
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

  Widget _buildInputField(TextEditingController controller) {
    return Container(
      width: 26,
      height: 40,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          color: Color(0xFF515151),
          fontSize: 16,
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

  Widget _buildRadioOption(String label) {
    return InkWell(
      onTap: () {
        setState(() {
          useOtherEmail = label == 'Usar outro email';
        });
      },
      child: Row(
        children: [
          Radio(
            value: label,
            groupValue: useOtherEmail ? 'Usar outro email' : 'jo***se@email.com',
            onChanged: (value) {
              setState(() {
                useOtherEmail = value == 'Usar outro email';
              });
            },
            activeColor: Colors.green, // Selected color
          ),
          Text(
            label,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              color: Color(0xFF515151),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

