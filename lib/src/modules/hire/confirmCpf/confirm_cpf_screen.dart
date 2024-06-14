 import 'package:flutter/material.dart';
 import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/modules/hire/confirmEmail/hire_confirm_email.dart';
 import 'package:passaqui/src/shared/widget/appbar.dart';
 import 'package:passaqui/src/shared/widget/button.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart'; // Assuming PassaquiButton is imported from here

 class HireConfirmCpfScreen extends StatefulWidget {
   static const String route = "/hire-confirm-cpf";
   final String? cpf;

   const HireConfirmCpfScreen({Key? key, this.cpf}) : super(key: key);

   @override
   State<HireConfirmCpfScreen> createState() => _HireConfirmCpfScreenState();
 }

 class _HireConfirmCpfScreenState extends State<HireConfirmCpfScreen> {
   TextEditingController _firstPartController = TextEditingController();
   TextEditingController _secondPartController = TextEditingController();
   TextEditingController _thirdPartController = TextEditingController();

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
                           _buildInputField(_firstPartController),
                           SizedBox(width: 2),
                           _buildInputField(_secondPartController),
                           SizedBox(width: 2),
                           _buildInputField(_thirdPartController),
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
           color: Colors.black,
           fontSize: 12,
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


//import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:passaqui/src/shared/widget/appbar.dart';
//import 'package:passaqui/src/shared/widget/button.dart'; // Assuming PassaquiButton is imported from here
//
//class HireConfirmCpfScreen extends StatefulWidget {
//  static const String route = "/hire-confirm-cpf";
//  final String? cpf;
//
//  const HireConfirmCpfScreen({Key? key, this.cpf}) : super(key: key);
//
//  @override
//  State<HireConfirmCpfScreen> createState() => _HireConfirmCpfScreenState();
//}
//
//class _HireConfirmCpfScreenState extends State<HireConfirmCpfScreen> {
//  TextEditingController _firstPartController = TextEditingController();
//  TextEditingController _secondPartController = TextEditingController();
//  TextEditingController _thirdPartController = TextEditingController();
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: const PassaquiAppBar(
//        showLogo: false,
//        showBackButton: true,
//      ),
//      backgroundColor: Color.fromRGBO(18, 96, 73, 1),
//      body: Stack(
//        children: [
//          Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: [
//              Padding(
//                padding: const EdgeInsets.only(left: 24.0, top: 16),
//                child: Text(
//                  'Informações básicas',
//                  style: GoogleFonts.roboto(
//                    color: Colors.white,
//                    fontSize: 20,
//                    fontWeight: FontWeight.w500,
//                  ),
//                ),
//              ),
//              SizedBox(height: 24),
//              Expanded(
//                child: Container(
//                  color: Colors.white,
//                  padding: EdgeInsets.all(16),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      SizedBox(height: 16),
//                      Center(
//                        child: Text(
//                          'Confirme os 3 primeiros dígitos do seu CPF:',
//                          style: GoogleFonts.roboto(
//                            fontWeight: FontWeight.w500,
//                            color: Color(0xFF515151),
//                            fontSize: 16,
//                          ),
//                        ),
//                      ),
//                      SizedBox(height: 24),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          _buildInputField(_firstPartController),
//                          SizedBox(width: 2),
//                          _buildInputField(_secondPartController),
//                          SizedBox(width: 2),
//                          _buildInputField(_thirdPartController),
//                          SizedBox(width: 2),
//                          _buildNumberText(widget.cpf != null && widget.cpf!.length >= 6 ? '.${widget.cpf!.substring(3, 6)}' : '.'),
//                          SizedBox(width: 2),
//                          _buildNumberText(widget.cpf != null && widget.cpf!.length >= 9 ? '.${widget.cpf!.substring(6, 9)}' : '.'),
//                          SizedBox(width: 2),
//                          _buildNumberText(widget.cpf != null && widget.cpf!.length >= 11 ? '-${widget.cpf!.substring(9)}' : '-'),
//                        ],
//                      ),
//                      SizedBox(height: 48),
//                      Center(
//                        child: PassaquiButton(
//                          label: 'Confirmar',
//                          centerText: true,
//                          borderRadius: 50,
//                          style: PassaquiButtonStyle.primary,
//                          onTap: () {
//                            // Print the values of the inputs
//                            String firstPart = _firstPartController.text;
//                            String secondPart = _secondPartController.text;
//                            String thirdPart = _thirdPartController.text;
//
//                            print('Primeiro dígito: $firstPart');
//                            print('Segundo dígito: $secondPart');
//                            print('Terceiro dígito: $thirdPart');
//                          },
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget _buildNumberText(String text) {
//    return Text(
//      text,
//      style: GoogleFonts.roboto(
//        fontWeight: FontWeight.w400,
//        color: Color(0xFF515151),
//        fontSize: 40,
//      ),
//    );
//  }
//
//  Widget _buildInputField(TextEditingController controller) {
//    return Container(
//      width: 40, // Adjust width as needed
//      height: 40, // Adjust height as needed
//      child: TextField(
//        controller: controller,
//        textAlignVertical: TextAlignVertical.bottom, // Align text to the bottom
//        textAlign: TextAlign.center, // Center align horizontally
//        keyboardType: TextInputType.number,
//        maxLength: 1,
//        onChanged: (value) {
//          // Update the controller's text
//          controller.text = value;
//          // Move cursor to the end of the text
//          controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
//        },
//        style: GoogleFonts.roboto(
//          fontWeight: FontWeight.w400,
//          color: Color(0xFF515151), // Same color as CPF numbers
//          fontSize: 40, // Same font size as CPF numbers
//        ),
//        decoration: InputDecoration(
//          filled: true,
//          fillColor: Color(0xFFF2F2F2),
//          counterText: "",
//          contentPadding: EdgeInsets.only(bottom: 8), // Adjust padding to align text
//          border: OutlineInputBorder(
//            borderSide: BorderSide.none,
//            borderRadius: BorderRadius.circular(8),
//          ),
//          prefix: SizedBox(height: 40, child: Container()), // Empty container for height
//          prefixIconConstraints: BoxConstraints(
//            minWidth: 0, // Min width to make it work
//          ),
//        ),
//      ),
//    );
//  }
//}
//