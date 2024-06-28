//
// import 'package:flutter/material.dart';
// import 'package:passaqui/src/core/di/service_locator.dart';
// import 'package:passaqui/src/core/navigation/navigation_handler.dart';
// import 'package:passaqui/src/modules/hire/steps/hire_step_screen.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:passaqui/src/shared/widget/card.dart';
// import 'package:passaqui/src/shared/widget/card_product.dart';
// import 'package:passaqui/src/services/auth_service.dart'; // Import AuthService
//
// class HomeScreen extends StatefulWidget {
//   static const String route = "/home";
//
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   String userName = ''; // Variable to hold the user's name
//   final AuthService _authService = DIService().inject<AuthService>(); // Get AuthService instance
//
//   @override
//   void initState() {
//     super.initState();
//     loadUserName();
//   }
//
//   Future<void> loadUserName() async {
//     try {
//       final name = await _authService.getName();
//       setState(() {
//         userName = name ?? ''; // Update the userName variable
//       });
//     } catch (e) {
//       print('Failed to load user name: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFe3e1e1),
//       body: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 color: Theme.of(context).primaryColor,
//                 width: double.infinity,
//                 height: 280,
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 28, top: 70),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Image.asset(
//                               "assets/images/ellipse.png",
//                               height: 40,
//                               width: 40,
//                             ),
//                             const SizedBox(width: 10),
//                             RichText(
//                               text: TextSpan(
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontSize: 24,
//                                   color: Colors.white,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                     text: 'Olá, ',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: userName,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Spacer(),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 28.0),
//                               child: Image.asset(
//                                 "assets/images/notification_bell.png",
//                                 height: 34,
//                                 width: 34,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             top: 160,
//             left: 16,
//             right: 16,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 PassaquiCard(
//                   height: 160,
//                   content: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 120,
//                           height: 120,
//                           child: Image.asset(
//                             "assets/images/logo_passaqui_round.png",
//                           ),
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   "Antecipe seu FGTS",
//                                   style: TextStyle(
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const Text(
//                                   "Uma forma simples e fácil de dar alívio nas suas despesas",
//                                   style: TextStyle(
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 PassaquiButton(
//                                   label: "Solicite agora",
//                                   showArrow: true,
//                                   style: PassaquiButtonStyle.primary,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                   height: 36,
//                                   width: 250,
//                                   onTap: () {
//                                     DIService()
//                                         .inject<NavigationHandler>()
//                                         .navigate(HireStepsScreen.route);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 34),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 16.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Em breve: ',
//                       style: TextStyle(
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: Color(0xFF383737),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 187,
//                         height: 225,
//                         child: PassaquiProductCard(
//                           imagePath: "assets/images/money_bag.png",
//                           title: "Crédito Consignado Privado",
//                           description:
//                           "Empréstimos com as melhores taxas e desconto direto em folha.",
//                           onPressed: () {
//                             // Handle button press for product 1
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 187,
//                         height: 225,
//                         child: PassaquiProductCard(
//                           imagePath: "assets/images/dollar_round.png",
//                           title: "Grande Sacado",
//                           description:
//                           "Antecipe recebíveis sem burocracia. Mais agilidade para pagamentos, com atendimento personalizado de acordo com a necessidade da sua empresa.",
//                           onPressed: () {
//                             // Handle button press for product 2
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 34),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 16.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Fique por dentro: ',
//                       style: TextStyle(
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: Color(0xFF383737),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 SizedBox(
//                   width: double.infinity,
//                   child: Card(
//                     color: const Color(0xFFD9D9D9),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Esteja por dentro do que está rolando no mundo financeiro, receba dicas e muito mais!',
//                             style: TextStyle(
//                               fontFamily: 'Inter',
//                               fontSize: 14,
//                               color: Color(0xFF383737),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           PassaquiButton(
//                             label: 'Acesse',
//                             showArrow: true,
//                             width: 160,
//                             height: 30,
//                             textColor: Colors.black,
//                             iconColor: Colors.black,
//                             fontSize: 12,
//                             arrowSize: 14.0,
//                             fontWeight: FontWeight.w400,
//                             style: PassaquiButtonStyle.secondary,
//                             onTap: () {
//                               // Handle button press
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:passaqui/src/core/di/service_locator.dart';
// import 'package:passaqui/src/core/navigation/navigation_handler.dart';
// import 'package:passaqui/src/modules/hire/steps/hire_step_screen.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:passaqui/src/shared/widget/card.dart';
// import 'package:passaqui/src/shared/widget/card_product.dart';
// import 'package:passaqui/src/services/auth_service.dart'; // Import AuthService
//
// class HomeScreen extends StatefulWidget {
//   static const String route = "/home";
//
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   String userName = ''; // Variable to hold the user's name
//   final AuthService _authService = DIService().inject<AuthService>(); // Get AuthService instance
//
//   @override
//   void initState() {
//     super.initState();
//     loadUserName();
//   }
//
//   Future<void> loadUserName() async {
//     try {
//       final name = await _authService.getName();
//       setState(() {
//         userName = name ?? ''; // Update the userName variable
//       });
//     } catch (e) {
//       print('Failed to load user name: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFe3e1e1),
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   color: Theme.of(context).primaryColor,
//                   width: double.infinity,
//                   height: 280,
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 28, top: 70),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Image.asset(
//                                 "assets/images/ellipse.png",
//                                 height: 40,
//                                 width: 40,
//                               ),
//                               const SizedBox(width: 10),
//                               RichText(
//                                 text: TextSpan(
//                                   style: TextStyle(
//                                     fontFamily: 'Inter',
//                                     fontSize: 24,
//                                     color: Colors.white,
//                                   ),
//                                   children: [
//                                     TextSpan(
//                                       text: 'Olá, ',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text: userName,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Spacer(),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 28.0),
//                                 child: Image.asset(
//                                   "assets/images/notification_bell.png",
//                                   height: 34,
//                                   width: 34,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 80), // Adjust this height to match the card's height + margin
//                 const Padding(
//                   padding: EdgeInsets.only(left: 16.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Em breve: ',
//                       style: TextStyle(
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: Color(0xFF383737),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 187,
//                         height: 225,
//                         child: PassaquiProductCard(
//                           imagePath: "assets/images/money_bag.png",
//                           title: "Crédito Consignado Privado",
//                           description:
//                           "Empréstimos com as melhores taxas e desconto direto em folha.",
//                           onPressed: () {
//                             // Handle button press for product 1
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 187,
//                         height: 225,
//                         child: PassaquiProductCard(
//                           imagePath: "assets/images/dollar_round.png",
//                           title: "Grande Sacado",
//                           description:
//                           "Antecipe recebíveis sem burocracia. Mais agilidade para pagamentos, com atendimento personalizado de acordo com a necessidade da sua empresa.",
//                           onPressed: () {
//                             // Handle button press for product 2
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 34),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 16.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Fique por dentro: ',
//                       style: TextStyle(
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: Color(0xFF383737),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: Card(
//                       color: const Color(0xFFD9D9D9),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Esteja por dentro do que está rolando no mundo financeiro, receba dicas e muito mais!',
//                               style: TextStyle(
//                                 fontFamily: 'Inter',
//                                 fontSize: 14,
//                                 color: Color(0xFF383737),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             PassaquiButton(
//                               label: 'Acesse',
//                               showArrow: true,
//                               width: 160,
//                               height: 30,
//                               textColor: Colors.black,
//                               iconColor: Colors.black,
//                               fontSize: 12,
//                               arrowSize: 14.0,
//                               fontWeight: FontWeight.w400,
//                               style: PassaquiButtonStyle.secondary,
//                               onTap: () {
//                                 // Handle button press
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               top: 170, // Adjust this value to position the card correctly
//               left: 16,
//               right: 16,
//               child: PassaquiCard(
//                 height: 160,
//                 content: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 120,
//                         height: 120,
//                         child: Image.asset(
//                           "assets/images/logo_passaqui_round.png",
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 "Antecipe seu FGTS",
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 22,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               const Text(
//                                 "Uma forma simples e fácil de dar alívio nas suas despesas",
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               PassaquiButton(
//                                 label: "Solicite agora",
//                                 showArrow: true,
//                                 style: PassaquiButtonStyle.primary,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 height: 36,
//                                 width: 250,
//                                 onTap: () {
//                                   DIService()
//                                       .inject<NavigationHandler>()
//                                       .navigate(HireStepsScreen.route);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:passaqui/src/core/di/service_locator.dart';
// import 'package:passaqui/src/core/navigation/navigation_handler.dart';
// import 'package:passaqui/src/modules/hire/steps/hire_step_screen.dart';
// import 'package:passaqui/src/services/auth_service.dart'; // Import AuthService
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:passaqui/src/shared/widget/card.dart';
// import 'package:passaqui/src/shared/widget/card_product.dart';
//
// class HomeScreen extends StatefulWidget {
//   static const String route = "/home";
//
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   String userName = ''; // Variable to hold the user's name
//   final AuthService _authService =
//       DIService().inject<AuthService>(); // Get AuthService instance
//
//   @override
//   void initState() {
//     super.initState();
//     loadUserName();
//   }
//
//   Future<void> loadUserName() async {
//     try {
//       final name = await _authService.getName();
//       setState(() {
//         userName = name ?? ''; // Update the userName variable
//       });
//     } catch (e) {
//       print('Failed to load user name: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFe3e1e1),
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   color: Theme.of(context).primaryColor,
//                   width: double.infinity,
//                   height: 280,
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 28, top: 70),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Image.asset(
//                                 "assets/images/ellipse.png",
//                                 height: 40,
//                                 width: 40,
//                               ),
//                               const SizedBox(width: 10),
//                               RichText(
//                                 text: TextSpan(
//                                   style: TextStyle(
//                                     fontFamily: 'Inter',
//                                     fontSize: 24,
//                                     color: Colors.white,
//                                   ),
//                                   children: [
//                                     TextSpan(
//                                       text: 'Olá, ',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text: userName,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Spacer(),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 28.0),
//                                 child: Image.asset(
//                                   "assets/images/notification_bell.png",
//                                   height: 34,
//                                   width: 34,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 80),
//                 // Adjust this height to match the card's height + margin
//                 const Padding(
//                   padding: EdgeInsets.only(left: 16.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Em breve: ',
//                       style: TextStyle(
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: Color(0xFF383737),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 187,
//                         height: 225,
//                         child: PassaquiProductCard(
//                           imagePath: "assets/images/money_bag.png",
//                           title: "Crédito Consignado Privado",
//                           description:
//                               "Empréstimos com as melhores taxas e desconto direto em folha.",
//                           onPressed: () {
//                             print("Continue clicado");
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 187,
//                         height: 225,
//                         child: PassaquiProductCard(
//                           imagePath: "assets/images/dollar_round.png",
//                           title: "Grande Sacado",
//                           description:
//                               "Antecipe recebíveis sem burocracia. Mais agilidade para pagamentos, com atendimento personalizado de acordo com a necessidade da sua empresa.",
//                           onPressed: () {
//                             print("Continue 2 clicado");
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 34),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 16.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Fique por dentro: ',
//                       style: TextStyle(
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: Color(0xFF383737),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 SizedBox(
//                   width: double.infinity,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Card(
//                       color: const Color(0xFFD9D9D9),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 16),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Esteja por dentro do que está rolando no mundo financeiro, receba dicas e muito mais!',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 12,
//                                       color: Color(0xFF383737),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 10),
//                                   PassaquiButton(
//                                     label: 'Acesse',
//                                     showArrow: true,
//                                     width: 160,
//                                     height: 30,
//                                     textColor: Colors.black,
//                                     iconColor: Colors.black,
//                                     fontSize: 12,
//                                     arrowSize: 14.0,
//                                     fontWeight: FontWeight.w400,
//                                     style: PassaquiButtonStyle.secondary,
//                                     onTap: () {
//                                       print("Acesse clicado");
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(12.0),
//                               child: Image.asset(
//                                 "assets/images/imagem_casal.png",
//                                 // Replace with your image path
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               top: 160, // Adjust this value to position the card correctly
//               left: 16,
//               right: 16,
//               child: PassaquiCard(
//                 height: 160,
//                 content: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 120,
//                         height: 120,
//                         child: Image.asset(
//                           "assets/images/logo_passaqui_round.png",
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 "Antecipe seu FGTS",
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 22,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               const Text(
//                                 "Uma forma simples e fácil de dar alívio nas suas despesas",
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               PassaquiButton(
//                                 label: "Solicite agora",
//                                 showArrow: true,
//                                 style: PassaquiButtonStyle.primary,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 height: 36,
//                                 width: 250,
//                                 onTap: () {
//                                   DIService()
//                                       .inject<NavigationHandler>()
//                                       .navigate(HireStepsScreen.route);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/biometria/biometria_error_screen.dart';
import 'package:passaqui/src/modules/biometria/biometria_success_screen.dart';
import 'package:passaqui/src/modules/biometria/wait/biometria_wait_screen.dart';
import 'package:passaqui/src/services/auth_service.dart'; // Import AuthService
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/card.dart';
import 'package:passaqui/src/shared/widget/card_product.dart';

import '../../services/biometria_service.dart';
import '../hire/steps/hire_step_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  final AuthService _authService =
  DIService().inject<AuthService>();
  late BiometriaService _biometriaService;

  @override
  void initState() {
    super.initState();
    loadUserName();
    _biometriaService = BiometriaService(_authService);
  }

  Future<void> loadUserName() async {
    try {
      final name = await _authService.getName();
      setState(() {
        userName = name ?? ''; // Update the userName variable
      });
    } catch (e) {
      print('Failed to load user name: $e');
    }
  }

  Future<void> fetchBiometriaData() async {
    try {
      final int biometriaStatus = await _biometriaService.fetchBiometriaData();
      switch (biometriaStatus) {
        case 0:
          print('Navigating to default route');
          DIService()
              .inject<NavigationHandler>()
              .navigate(BiometriaWaitScreen.route);
          break;
        case 1:
          print('Navigating to BiometriaErrorScreen');
          DIService()
              .inject<NavigationHandler>()
              .navigate(BiometriaErrorScreen.route);

          break;
        case 2:
          print('Navigating to BiometriaSuccessScreen');
          DIService()
              .inject<NavigationHandler>()
              .navigate(BiometriaSucessScreen.route);
          break;
        default:
          print('Unknown biometria status: $biometriaStatus');
          DIService()
              .inject<NavigationHandler>()
              .navigate(HireStepsScreen.route);
          break;
      }
    } catch (e) {
      print('Error fetching biometria data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe3e1e1),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  height: 280,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28, top: 70),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap:() {
                                  Navigator.of(context).pop();
                                  DIService()
                                      .inject<NavigationHandler>()
                                      .navigate(ProfileScreen.route);
                                },
                                child: Image.asset(
                                  "assets/images/ellipse.png",
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              const SizedBox(width: 10),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Olá, ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: userName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 28.0),
                                child: Image.asset(
                                  "assets/images/notification_bell.png",
                                  height: 34,
                                  width: 34,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 80),
                // Adjust this height to match the card's height + margin
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Em breve: ',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF383737),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 187,
                        height: 225,
                        child: PassaquiProductCard(
                          imagePath: "assets/images/money_bag.png",
                          title: "Crédito Consignado Privado",
                          description:
                          "Empréstimos com as melhores taxas e desconto direto em folha.",
                          onPressed: () {
                            print("Continue clicado");
                          },
                        ),
                      ),
                      SizedBox(
                        width: 187,
                        height: 225,
                        child: PassaquiProductCard(
                          imagePath: "assets/images/dollar_round.png",
                          title: "Grande Sacado",
                          description:
                          "Antecipe recebíveis sem burocracia. Mais agilidade para pagamentos, com atendimento personalizado de acordo com a necessidade da sua empresa.",
                          onPressed: () {
                            print("Continue 2 clicado");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 34),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Fique por dentro: ',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF383737),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      color: const Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Esteja por dentro do que está rolando no mundo financeiro, receba dicas e muito mais!',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      color: Color(0xFF383737),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  PassaquiButton(
                                    label: 'Acesse',
                                    showArrow: true,
                                    width: 160,
                                    height: 30,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    fontSize: 12,
                                    arrowSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    style: PassaquiButtonStyle.secondary,
                                    onTap: () {
                                      print("Acesse clicado");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                "assets/images/imagem_casal.png",
                                // Replace with your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 160, // Adjust this value to position the card correctly
              left: 16,
              right: 16,
              child: PassaquiCard(
                height: 160,
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.asset(
                          "assets/images/logo_passaqui_round.png",
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Antecipe seu FGTS",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Uma forma simples e fácil de dar alívio nas suas despesas",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await fetchBiometriaData();
                                  // Handle navigation based on biometria status if needed
                                  // For now, it just navigates to HireStepsScreen directly

                                },
                                child: PassaquiButton(
                                  label: "Solicite agora",
                                  showArrow: true,
                                  style: PassaquiButtonStyle.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 36,
                                  width: 250,
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}