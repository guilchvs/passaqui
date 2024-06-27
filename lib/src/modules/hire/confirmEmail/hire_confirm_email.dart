// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:passaqui/src/shared/widget/appbar.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:url_launcher/url_launcher_string.dart';
//
// import '../../../core/di/service_locator.dart';
// import '../../../core/navigation/navigation_handler.dart';
// import '../../../services/auth_service.dart';
// import '../wrongInfo/wrong_cpf_screen.dart';
//
// class HireConfirmEmailScreen extends StatefulWidget {
//   static const String route = "/hire-confirm-email";
//   final String? cpf;
//
//   const HireConfirmEmailScreen({Key? key, this.cpf}) : super(key: key);
//
//   @override
//   State<HireConfirmEmailScreen> createState() => _HireConfirmEmailScreenState();
// }
//
// class _HireConfirmEmailScreenState extends State<HireConfirmEmailScreen> {
//   bool useOtherEmail = false; // Track the state of the radio buttons
//   final AuthService _authService = AuthService();
//   bool _isLoading = false;
//   Map<String, dynamic>? _jsonResponse;
//   String? userEmail; // Variable to hold the user's email
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserEmail(); // Fetch user's email when screen initializes
//   }
//
//   Future<void> _fetchUserEmail() async {
//     // Fetch user's email from SharedPreferences
//     userEmail = await _authService.getEmail();
//     setState(() {
//       // Trigger a UI update
//     });
//   }
//
//   Future<void> _simulateApiCall(String? cpf) async {
//     setState(() {
//       _isLoading = true; // Set loading state while waiting for API response
//     });
//
//     final baseUrl =
//         'http://passcash-api-hml.us-east-1.elasticbeanstalk.com'; // Replace with your API base URL
//     final token = await _authService.getToken(); // Retrieve JWT token
//     final url = Uri.parse('$baseUrl/api/ApiMaster/iniciarBiometria?cpf=$cpf');
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
//         final _url = response.body;
//         await launchUrlString(_url);
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
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0),
//                         // Adjust left padding as needed
//                         child: Text(
//                           'Email atual',
//                           style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF515151),
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 46),
//                       _buildRadioOption(userEmail ?? ''),
//                       // Display user's masked email
//                       SizedBox(height: 54),
//                       Center(
//                         child: PassaquiButton(
//                           label: 'Confirmar',
//                           centerText: true,
//                           borderRadius: 50,
//                           style: PassaquiButtonStyle.primary,
//                           onTap: () {
//                             _simulateApiCall(widget.cpf);
//                             // Handle button tap
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 28),
//                       Center(
//                           child: GestureDetector(
//                               onTap: () {
//                                 DIService().inject<NavigationHandler>().navigate(
//                                   WrongPersonalInfoScreen.route,
//                                   arguments: {'isEmail': true},
//                                 );
//                               },
//                               child: Text("Não é seu email? Clique aqui",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 18,
//                                     fontFamily: 'Roboto',
//                                     color: Color(0xFF136048),
//                                     decoration: TextDecoration.underline,
//                                   ))))
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
//   Widget _buildRadioOption(String email) {
//     if (email.isEmpty) {
//       return SizedBox.shrink(); // If email is empty, return an empty SizedBox
//     }
//
//     // Split the email into parts before and after '@'
//     List<String> emailParts = email.split('@');
//     if (emailParts.length != 2) {
//       return SizedBox
//           .shrink(); // If email format is invalid, return an empty SizedBox
//     }
//
//     String maskedEmail =
//         '${emailParts[0].substring(0, 2)}${'*' * (emailParts[0].length - 2)}@${emailParts[1]}';
//
//     return InkWell(
//       onTap: () {
//         setState(() {
//           useOtherEmail = true; // Always toggle to 'Use another email' option
//         });
//       },
//       child: Row(
//         children: [
//           Radio(
//             value: maskedEmail,
//             groupValue: useOtherEmail ? 'Usar outro email' : maskedEmail,
//             onChanged: (value) {
//               setState(() {
//                 useOtherEmail = value == 'Usar outro email';
//               });
//             },
//             activeColor: Colors.green, // Selected color
//           ),
//           Text(
//             maskedEmail,
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
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:passaqui/src/shared/widget/appbar.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:webview_flutter/webview_flutter.dart'; // New import for WebView
//
// import '../../../core/di/service_locator.dart';
// import '../../../core/navigation/navigation_handler.dart';
// import '../../../services/auth_service.dart';
// import '../wrongInfo/wrong_cpf_screen.dart';
//
// class HireConfirmEmailScreen extends StatefulWidget {
//   static const String route = "/hire-confirm-email";
//   final String? cpf;
//
//   const HireConfirmEmailScreen({Key? key, this.cpf}) : super(key: key);
//
//   @override
//   State<HireConfirmEmailScreen> createState() => _HireConfirmEmailScreenState();
// }
//
// class _HireConfirmEmailScreenState extends State<HireConfirmEmailScreen> {
//   bool useOtherEmail = false; // Track the state of the radio buttons
//   final AuthService _authService = AuthService();
//   bool _isLoading = false;
//   Map<String, dynamic>? _jsonResponse;
//   String? userEmail; // Variable to hold the user's email
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserEmail(); // Fetch user's email when screen initializes
//   }
//
//   Future<void> _fetchUserEmail() async {
//     // Fetch user's email from SharedPreferences
//     userEmail = await _authService.getEmail();
//     setState(() {
//       // Trigger a UI update
//     });
//   }
//
//   Future<void> _simulateApiCall(String? cpf) async {
//     setState(() {
//       _isLoading = true; // Set loading state while waiting for API response
//     });
//
//     final baseUrl =
//         'http://passcash-api-hml.us-east-1.elasticbeanstalk.com'; // Replace with your API base URL
//     final token = await _authService.getToken(); // Retrieve JWT token
//     final url = Uri.parse('$baseUrl/api/ApiMaster/iniciarBiometria?cpf=$cpf');
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
//         final _url = response.body;
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => WebViewScreen(url: _url),
//           ),
//         );
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
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0),
//                         // Adjust left padding as needed
//                         child: Text(
//                           'Email atual',
//                           style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF515151),
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 46),
//                       _buildRadioOption(userEmail ?? ''),
//                       // Display user's masked email
//                       SizedBox(height: 54),
//                       Center(
//                         child: PassaquiButton(
//                           label: 'Confirmar',
//                           centerText: true,
//                           borderRadius: 50,
//                           style: PassaquiButtonStyle.primary,
//                           onTap: () {
//                             _simulateApiCall(widget.cpf);
//                             // Handle button tap
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 28),
//                       Center(
//                           child: GestureDetector(
//                               onTap: () {
//                                 DIService().inject<NavigationHandler>().navigate(
//                                   WrongPersonalInfoScreen.route,
//                                   arguments: {'isEmail': true},
//                                 );
//                               },
//                               child: Text("Não é seu email? Clique aqui",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 18,
//                                     fontFamily: 'Roboto',
//                                     color: Color(0xFF136048),
//                                     decoration: TextDecoration.underline,
//                                   ))))
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
//   Widget _buildRadioOption(String email) {
//     if (email.isEmpty) {
//       return SizedBox.shrink(); // If email is empty, return an empty SizedBox
//     }
//
//     // Split the email into parts before and after '@'
//     List<String> emailParts = email.split('@');
//     if (emailParts.length != 2) {
//       return SizedBox
//           .shrink(); // If email format is invalid, return an empty SizedBox
//     }
//
//     String maskedEmail =
//         '${emailParts[0].substring(0, 2)}${'*' * (emailParts[0].length - 2)}@${emailParts[1]}';
//
//     return InkWell(
//       onTap: () {
//         setState(() {
//           useOtherEmail = true; // Always toggle to 'Use another email' option
//         });
//       },
//       child: Row(
//         children: [
//           Radio(
//             value: maskedEmail,
//             groupValue: useOtherEmail ? 'Usar outro email' : maskedEmail,
//             onChanged: (value) {
//               setState(() {
//                 useOtherEmail = value == 'Usar outro email';
//               });
//             },
//             activeColor: Colors.green, // Selected color
//           ),
//           Text(
//             maskedEmail,
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
//
// class WebViewScreen extends StatelessWidget {
//   final String url;
//
//   WebViewScreen({required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PassaquiAppBar(
//         showBackButton: true,
//         showLogo: false,
//         title: "Biometria",
//       ),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:passaqui/src/shared/widget/appbar.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:webview_flutter/webview_flutter.dart'; // New import for WebView
//
// import '../../../core/di/service_locator.dart';
// import '../../../core/navigation/navigation_handler.dart';
// import '../../../services/auth_service.dart';
// import '../wrongInfo/wrong_cpf_screen.dart';
//
// class HireConfirmEmailScreen extends StatefulWidget {
//   static const String route = "/hire-confirm-email";
//   final String? cpf;
//
//   const HireConfirmEmailScreen({Key? key, this.cpf}) : super(key: key);
//
//   @override
//   State<HireConfirmEmailScreen> createState() => _HireConfirmEmailScreenState();
// }
//
// class _HireConfirmEmailScreenState extends State<HireConfirmEmailScreen> {
//   bool useOtherEmail = false;
//   final AuthService _authService = AuthService();
//   bool _isLoading = false;
//   Map<String, dynamic>? _jsonResponse;
//   String? userEmail;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserEmail();
//   }
//
//   Future<void> _fetchUserEmail() async {
//     // Fetch user's email from SharedPreferences
//     userEmail = await _authService.getEmail();
//     setState(() {
//       // Trigger a UI update
//     });
//   }
//
//   Future<void> _simulateApiCall(String? cpf) async {
//     setState(() {
//       _isLoading = true; // Set loading state while waiting for API response
//     });
//
//     final baseUrl =
//         'http://passcash-api-hml.us-east-1.elasticbeanstalk.com'; // Replace with your API base URL
//     final token = await _authService.getToken(); // Retrieve JWT token
//     final url = Uri.parse('$baseUrl/api/ApiMaster/iniciarBiometria?cpf=$cpf');
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
//         final _url = response.body;
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => WebViewScreen(url: _url),
//           ),
//         );
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
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0),
//                         // Adjust left padding as needed
//                         child: Text(
//                           'Email atual',
//                           style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF515151),
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 46),
//                       _buildRadioOption(userEmail ?? ''),
//                       // Display user's masked email
//                       SizedBox(height: 54),
//                       Center(
//                         child: PassaquiButton(
//                           label: 'Confirmar',
//                           centerText: true,
//                           borderRadius: 50,
//                           style: PassaquiButtonStyle.primary,
//                           onTap: () {
//                             _simulateApiCall(widget.cpf);
//                             // Handle button tap
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 28),
//                       Center(
//                           child: GestureDetector(
//                               onTap: () {
//                                 DIService().inject<NavigationHandler>().navigate(
//                                   WrongPersonalInfoScreen.route,
//                                   arguments: {'isEmail': true},
//                                 );
//                               },
//                               child: Text("Não é seu email? Clique aqui",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 18,
//                                     fontFamily: 'Roboto',
//                                     color: Color(0xFF136048),
//                                     decoration: TextDecoration.underline,
//                                   ))))
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
//   Widget _buildRadioOption(String email) {
//     if (email.isEmpty) {
//       return SizedBox.shrink(); // If email is empty, return an empty SizedBox
//     }
//
//     // Split the email into parts before and after '@'
//     List<String> emailParts = email.split('@');
//     if (emailParts.length != 2) {
//       return SizedBox
//           .shrink(); // If email format is invalid, return an empty SizedBox
//     }
//
//     String maskedEmail =
//         '${emailParts[0].substring(0, 2)}${'*' * (emailParts[0].length - 2)}@${emailParts[1]}';
//
//     return InkWell(
//       onTap: () {
//         setState(() {
//           useOtherEmail = true; // Always toggle to 'Use another email' option
//         });
//       },
//       child: Row(
//         children: [
//           Radio(
//             value: maskedEmail,
//             groupValue: useOtherEmail ? 'Usar outro email' : maskedEmail,
//             onChanged: (value) {
//               setState(() {
//                 useOtherEmail = value == 'Usar outro email';
//               });
//             },
//             activeColor: Colors.green, // Selected color
//           ),
//           Text(
//             maskedEmail,
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
//
// class WebViewScreen extends StatelessWidget {
//   final String url;
//
//   WebViewScreen({required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PassaquiAppBar(
//         showBackButton: true,
//         showLogo: false,
//         title: "Biometria",
//       ),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:passaqui/src/shared/widget/appbar.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
//
// import '../../../core/di/service_locator.dart';
// import '../../../core/navigation/navigation_handler.dart';
// import '../../../services/auth_service.dart';
// import '../wrongInfo/wrong_cpf_screen.dart';
//
// class HireConfirmEmailScreen extends StatefulWidget {
//   static const String route = "/hire-confirm-email";
//   final String? cpf;
//
//   const HireConfirmEmailScreen({Key? key, this.cpf}) : super(key: key);
//
//   @override
//   State<HireConfirmEmailScreen> createState() => _HireConfirmEmailScreenState();
// }
//
// class _HireConfirmEmailScreenState extends State<HireConfirmEmailScreen> {
//   bool useOtherEmail = false;
//   final AuthService _authService = AuthService();
//   bool _isLoading = false;
//   String? userEmail;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserEmail();
//   }
//
//   Future<void> _fetchUserEmail() async {
//     userEmail = await _authService.getEmail();
//     setState(() {});
//   }
//
//   Future<void> _simulateApiCall(String? cpf) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     final baseUrl = 'http://passcash-api-hml.us-east-1.elasticbeanstalk.com';
//     final token = await _authService.getToken();
//     final url = Uri.parse('$baseUrl/api/ApiMaster/iniciarBiometria?cpf=$cpf');
//
//     try {
//       final response = await http.post(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final _url = response.body;
//         _handleCameraPermission(_url);
//       } else {
//         print('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _handleCameraPermission(String url) async {
//     PermissionStatus status = await Permission.camera.request();
//
//     if (status.isGranted) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => WebViewScreen(url: url),
//         ),
//       );
//     } else {
//       print('Camera permission denied.');
//       // Handle the denial as needed
//       // For example, show a snackbar or alert dialog to inform the user
//     }
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
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           'Email atual',
//                           style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF515151),
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 46),
//                       _buildRadioOption(userEmail ?? ''),
//                       SizedBox(height: 54),
//                       Center(
//                         child: PassaquiButton(
//                           label: 'Confirmar',
//                           centerText: true,
//                           borderRadius: 50,
//                           style: PassaquiButtonStyle.primary,
//                           onTap: () {
//                             _simulateApiCall(widget.cpf);
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 28),
//                       Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             DIService()
//                                 .inject<NavigationHandler>()
//                                 .navigate(
//                               WrongPersonalInfoScreen.route,
//                               arguments: {'isEmail': true},
//                             );
//                           },
//                           child: Text(
//                             "Não é seu email? Clique aqui",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               color: Color(0xFF136048),
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
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
//   Widget _buildRadioOption(String email) {
//     if (email.isEmpty) {
//       return SizedBox.shrink();
//     }
//
//     List<String> emailParts = email.split('@');
//     if (emailParts.length != 2) {
//       return SizedBox.shrink();
//     }
//
//     String maskedEmail =
//         '${emailParts[0].substring(0, 2)}${'*' * (emailParts[0].length - 2)}@${emailParts[1]}';
//
//     return InkWell(
//       onTap: () {
//         setState(() {
//           useOtherEmail = true;
//         });
//       },
//       child: Row(
//         children: [
//           Radio(
//             value: maskedEmail,
//             groupValue: useOtherEmail ? 'Usar outro email' : maskedEmail,
//             onChanged: (value) {
//               setState(() {
//                 useOtherEmail = value == 'Usar outro email';
//               });
//             },
//             activeColor: Colors.green,
//           ),
//           Text(
//             maskedEmail,
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
//
// class WebViewScreen extends StatelessWidget {
//   final String url;
//
//   WebViewScreen({required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PassaquiAppBar(
//         showBackButton: true,
//         showLogo: false,
//         title: "Biometria",
//       ),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:passaqui/src/shared/widget/appbar.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
//
// import '../../../core/di/service_locator.dart';
// import '../../../core/navigation/navigation_handler.dart';
// import '../../../services/auth_service.dart';
// import '../wrongInfo/wrong_cpf_screen.dart';
//
// class HireConfirmEmailScreen extends StatefulWidget {
//   static const String route = "/hire-confirm-email";
//   final String? cpf;
//
//   const HireConfirmEmailScreen({Key? key, this.cpf}) : super(key: key);
//
//   @override
//   State<HireConfirmEmailScreen> createState() => _HireConfirmEmailScreenState();
// }
//
// class _HireConfirmEmailScreenState extends State<HireConfirmEmailScreen> {
//   bool useOtherEmail = false;
//   final AuthService _authService = AuthService();
//   bool _isLoading = false;
//   String? userEmail;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserEmail();
//   }
//
//   Future<void> _fetchUserEmail() async {
//     userEmail = await _authService.getEmail();
//     setState(() {});
//   }
//
//   Future<void> _simulateApiCall(String? cpf) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     final baseUrl = 'http://passcash-api-hml.us-east-1.elasticbeanstalk.com';
//     final token = await _authService.getToken();
//     final url = Uri.parse('$baseUrl/api/ApiMaster/iniciarBiometria?cpf=$cpf');
//
//     try {
//       final response = await http.post(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final _url = response.body;
//         _handleCameraPermission(_url);
//       } else {
//         print('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _handleCameraPermission(String url) async {
//     PermissionStatus status = await Permission.camera.request();
//
//     if (status.isGranted) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => WebViewScreen(url: url),
//         ),
//       );
//     } else {
//       print('Camera permission denied.');
//       // Handle the denial as needed
//       // For example, show a snackbar or alert dialog to inform the user
//     }
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
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           'Email atual',
//                           style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF515151),
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 46),
//                       _buildRadioOption(userEmail ?? ''),
//                       SizedBox(height: 54),
//                       Center(
//                         child: PassaquiButton(
//                           label: 'Confirmar',
//                           centerText: true,
//                           borderRadius: 50,
//                           style: PassaquiButtonStyle.primary,
//                           onTap: () {
//                             _simulateApiCall(widget.cpf);
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 28),
//                       Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             DIService()
//                                 .inject<NavigationHandler>()
//                                 .navigate(
//                               WrongPersonalInfoScreen.route,
//                               arguments: {'isEmail': true},
//                             );
//                           },
//                           child: Text(
//                             "Não é seu email? Clique aqui",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               color: Color(0xFF136048),
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
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
//   Widget _buildRadioOption(String email) {
//     if (email.isEmpty) {
//       return SizedBox.shrink();
//     }
//
//     List<String> emailParts = email.split('@');
//     if (emailParts.length != 2) {
//       return SizedBox.shrink();
//     }
//
//     String maskedEmail =
//         '${emailParts[0].substring(0, 2)}${'*' * (emailParts[0].length - 2)}@${emailParts[1]}';
//
//     return InkWell(
//       onTap: () {
//         setState(() {
//           useOtherEmail = true;
//         });
//       },
//       child: Row(
//         children: [
//           Radio(
//             value: maskedEmail,
//             groupValue: useOtherEmail ? 'Usar outro email' : maskedEmail,
//             onChanged: (value) {
//               setState(() {
//                 useOtherEmail = value == 'Usar outro email';
//               });
//             },
//             activeColor: Colors.green,
//           ),
//           Text(
//             maskedEmail,
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
//
// class WebViewScreen extends StatelessWidget {
//   final String url;
//
//   WebViewScreen({required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PassaquiAppBar(
//         showBackButton: true,
//         showLogo: false,
//         title: "Biometria",
//       ),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:passaqui/src/shared/widget/appbar.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:webview_flutter/webview_flutter.dart'; // New import for WebView
// import 'package:permission_handler/permission_handler.dart'; // Import permission handler
//
// import '../../../core/di/service_locator.dart';
// import '../../../core/navigation/navigation_handler.dart';
// import '../../../services/auth_service.dart';
// import '../wrongInfo/wrong_cpf_screen.dart';
//
// class HireConfirmEmailScreen extends StatefulWidget {
//   static const String route = "/hire-confirm-email";
//   final String? cpf;
//
//   const HireConfirmEmailScreen({Key? key, this.cpf}) : super(key: key);
//
//   @override
//   State<HireConfirmEmailScreen> createState() => _HireConfirmEmailScreenState();
// }
//
// class _HireConfirmEmailScreenState extends State<HireConfirmEmailScreen> {
//   bool useOtherEmail = false; // Track the state of the radio buttons
//   final AuthService _authService = AuthService();
//   bool _isLoading = false;
//   Map<String, dynamic>? _jsonResponse;
//   String? userEmail; // Variable to hold the user's email
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserEmail(); // Fetch user's email when screen initializes
//   }
//
//   Future<void> _fetchUserEmail() async {
//     // Fetch user's email from SharedPreferences
//     userEmail = await _authService.getEmail();
//     setState(() {
//       // Trigger a UI update
//     });
//   }
//
//   Future<void> _simulateApiCall(String? cpf) async {
//     setState(() {
//       _isLoading = true; // Set loading state while waiting for API response
//     });
//
//     final baseUrl =
//         'http://passcash-api-hml.us-east-1.elasticbeanstalk.com'; // Replace with your API base URL
//     final token = await _authService.getToken(); // Retrieve JWT token
//     final url = Uri.parse('$baseUrl/api/ApiMaster/iniciarBiometria?cpf=$cpf');
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
//         final _url = response.body;
//         await _handleCameraPermission();
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => WebViewScreen(url: _url),
//           ),
//         );
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
//   Future<void> _handleCameraPermission() async {
//     var status = await Permission.camera.status;
//     if (!status.isGranted) {
//       status = await Permission.camera.request();
//     }
//
//     if (!status.isGranted) {
//       // Handle the case where the permission is denied
//       print('Camera permission denied');
//     }
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
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0),
//                         // Adjust left padding as needed
//                         child: Text(
//                           'Email atual',
//                           style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF515151),
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 46),
//                       _buildRadioOption(userEmail ?? ''),
//                       // Display user's masked email
//                       SizedBox(height: 54),
//                       Center(
//                         child: PassaquiButton(
//                           label: 'Confirmar',
//                           centerText: true,
//                           borderRadius: 50,
//                           style: PassaquiButtonStyle.primary,
//                           onTap: () {
//                             _simulateApiCall(widget.cpf);
//                             // Handle button tap
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 28),
//                       Center(
//                           child: GestureDetector(
//                               onTap: () {
//                                 DIService().inject<NavigationHandler>().navigate(
//                                   WrongPersonalInfoScreen.route,
//                                   arguments: {'isEmail': true},
//                                 );
//                               },
//                               child: Text("Não é seu email? Clique aqui",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 18,
//                                     fontFamily: 'Roboto',
//                                     color: Color(0xFF136048),
//                                     decoration: TextDecoration.underline,
//                                   ))))
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
//   Widget _buildRadioOption(String email) {
//     if (email.isEmpty) {
//       return SizedBox.shrink(); // If email is empty, return an empty SizedBox
//     }
//
//     // Split the email into parts before and after '@'
//     List<String> emailParts = email.split('@');
//     if (emailParts.length != 2) {
//       return SizedBox
//           .shrink(); // If email format is invalid, return an empty SizedBox
//     }
//
//     String maskedEmail =
//         '${emailParts[0].substring(0, 2)}${'*' * (emailParts[0].length - 2)}@${emailParts[1]}';
//
//     return InkWell(
//       onTap: () {
//         setState(() {
//           useOtherEmail = true; // Always toggle to 'Use another email' option
//         });
//       },
//       child: Row(
//         children: [
//           Radio(
//             value: maskedEmail,
//             groupValue: useOtherEmail ? 'Usar outro email' : maskedEmail,
//             onChanged: (value) {
//               setState(() {
//                 useOtherEmail = value == 'Usar outro email';
//               });
//             },
//             activeColor: Colors.green, // Selected color
//           ),
//           Text(
//             maskedEmail,
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
//
// class WebViewScreen extends StatelessWidget {
//   final String url;
//
//   WebViewScreen({required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PassaquiAppBar(
//         showBackButton: true,
//         showLogo: false,
//         title: "Biometria",
//       ),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:passaqui/src/shared/widget/appbar.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../../core/di/service_locator.dart';
// import '../../../core/navigation/navigation_handler.dart';
// import '../../../services/auth_service.dart';
// import '../wrongInfo/wrong_cpf_screen.dart';
//
// class HireConfirmEmailScreen extends StatefulWidget {
//   static const String route = "/hire-confirm-email";
//   final String? cpf;
//
//   const HireConfirmEmailScreen({Key? key, this.cpf}) : super(key: key);
//
//   @override
//   State<HireConfirmEmailScreen> createState() => _HireConfirmEmailScreenState();
// }
//
// class _HireConfirmEmailScreenState extends State<HireConfirmEmailScreen> {
//   bool useOtherEmail = false;
//   final AuthService _authService = AuthService();
//   bool _isLoading = false;
//   Map<String, dynamic>? _jsonResponse;
//   String? userEmail;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserEmail();
//     // For webview initialization on Android
//     if (WebView.platform == null) {
//       WebView.platform = SurfaceAndroidWebView();
//     }
//   }
//
//   Future<void> _fetchUserEmail() async {
//     userEmail = await _authService.getEmail();
//     setState(() {});
//   }
//
//   Future<void> _simulateApiCall(String? cpf) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     final baseUrl = 'http://passcash-api-hml.us-east-1.elasticbeanstalk.com';
//     final token = await _authService.getToken();
//     final url = Uri.parse('$baseUrl/api/ApiMaster/iniciarBiometria?cpf=$cpf');
//
//     try {
//       final response = await http.post(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final _url = response.body;
//         await _handleCameraPermission();
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => WebViewScreen(url: _url),
//           ),
//         );
//       } else {
//         print('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _handleCameraPermission() async {
//     var status = await Permission.camera.status;
//     if (!status.isGranted) {
//       status = await Permission.camera.request();
//     }
//
//     if (!status.isGranted) {
//       print('Camera permission denied');
//     }
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
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           'Email atual',
//                           style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF515151),
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 46),
//                       _buildRadioOption(userEmail ?? ''),
//                       SizedBox(height: 54),
//                       Center(
//                         child: PassaquiButton(
//                           label: 'Confirmar',
//                           centerText: true,
//                           borderRadius: 50,
//                           style: PassaquiButtonStyle.primary,
//                           onTap: () {
//                             _simulateApiCall(widget.cpf);
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 28),
//                       Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             DIService().inject<NavigationHandler>().navigate(
//                               WrongPersonalInfoScreen.route,
//                               arguments: {'isEmail': true},
//                             );
//                           },
//                           child: Text(
//                             "Não é seu email? Clique aqui",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               color: Color(0xFF136048),
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),
//                       )
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
//   Widget _buildRadioOption(String email) {
//     if (email.isEmpty) {
//       return SizedBox.shrink();
//     }
//
//     List<String> emailParts = email.split('@');
//     if (emailParts.length != 2) {
//       return SizedBox.shrink();
//     }
//
//     String maskedEmail = '${emailParts[0].substring(0, 2)}${'*' * (emailParts[0].length - 2)}@${emailParts[1]}';
//
//     return InkWell(
//       onTap: () {
//         setState(() {
//           useOtherEmail = true;
//         });
//       },
//       child: Row(
//         children: [
//           Radio(
//             value: maskedEmail,
//             groupValue: useOtherEmail ? 'Usar outro email' : maskedEmail,
//             onChanged: (value) {
//               setState(() {
//                 useOtherEmail = value == 'Usar outro email';
//               });
//             },
//             activeColor: Colors.green,
//           ),
//           Text(
//             maskedEmail,
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
//
// class WebViewScreen extends StatefulWidget {
//   final String url;
//
//   WebViewScreen({required this.url});
//
//   @override
//   _WebViewScreenState createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   late WebViewController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) {
//       WebView.platform = SurfaceAndroidWebView();
//     }
//     _handleCameraPermission();
//   }
//
//   Future<void> _handleCameraPermission() async {
//     var status = await Permission.camera.status;
//     if (!status.isGranted) {
//       status = await Permission.camera.request();
//     }
//
//     if (!status.isGranted) {
//       print('Camera permission denied');
//       // You might want to handle this case and show a message to the user.
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Biometria"),
//       ),
//       body: WebView(
//         initialUrl: widget.url,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController;
//         },
//         navigationDelegate: (NavigationRequest request) async {
//           if (request.url.startsWith('webrtc:')) {
//             await _handleCameraPermission();
//             return NavigationDecision.navigate;
//           }
//           return NavigationDecision.navigate;
//         },
//         onPageStarted: (String url) async {
//           if (await Permission.camera.isGranted) {
//             _controller.runJavascript('navigator.mediaDevices.getUserMedia({ video: true })');
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import '../../../services/auth_service.dart';
import '../wrongInfo/wrong_cpf_screen.dart';

class HireConfirmEmailScreen extends StatefulWidget {
  static const String route = "/hire-confirm-email";
  final String? cpf;

  const HireConfirmEmailScreen({Key? key, this.cpf}) : super(key: key);

  @override
  State<HireConfirmEmailScreen> createState() => _HireConfirmEmailScreenState();
}

class _HireConfirmEmailScreenState extends State<HireConfirmEmailScreen> {
  bool useOtherEmail = false;
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _fetchUserEmail();
  }

  Future<void> _fetchUserEmail() async {
    userEmail = await _authService.getEmail();
    setState(() {});
  }

  Future<void> _simulateApiCall(String? cpf) async {
    setState(() {
      _isLoading = true;
    });

    final baseUrl = 'http://passcash-api-hml.us-east-1.elasticbeanstalk.com';
    final token = await _authService.getToken();
    final url = Uri.parse('$baseUrl/api/ApiMaster/iniciarBiometria?cpf=$cpf');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final _url = response.body;
        await _handleCameraPermission();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: _url),
          ),
        );
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (!status.isGranted) {
      print('Camera permission denied');
      // Handle denied permission case
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PassaquiAppBar(
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
                  style: TextStyle(
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
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Email atual',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF515151),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 46),
                      _buildRadioOption(userEmail ?? ''),
                      SizedBox(height: 54),
                      Center(
                        child: PassaquiButton(
                          label: 'Confirmar',
                          centerText: true,
                          borderRadius: 50,
                          style: PassaquiButtonStyle.primary,
                          onTap: () {
                            _simulateApiCall(widget.cpf);
                          },
                        ),
                      ),
                      SizedBox(height: 28),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            DIService().inject<NavigationHandler>().navigate(
                              WrongPersonalInfoScreen.route,
                              arguments: {'isEmail': true},
                            );
                          },
                          child: Text(
                            "Não é seu email? Clique aqui",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              color: Color(0xFF136048),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
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

  Widget _buildRadioOption(String email) {
    if (email.isEmpty) {
      return SizedBox.shrink();
    }

    List<String> emailParts = email.split('@');
    if (emailParts.length != 2) {
      return SizedBox.shrink();
    }

    String maskedEmail = '${emailParts[0].substring(0, 2)}${'*' * (emailParts[0].length - 2)}@${emailParts[1]}';

    return InkWell(
      onTap: () {
        setState(() {
          useOtherEmail = true;
        });
      },
      child: Row(
        children: [
          Radio(
            value: maskedEmail,
            groupValue: useOtherEmail ? 'Usar outro email' : maskedEmail,
            onChanged: (value) {
              setState(() {
                useOtherEmail = value == 'Usar outro email';
              });
            },
            activeColor: Colors.green,
          ),
          Text(
            maskedEmail,
            style: TextStyle(
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

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            print('''
            Page resource error:
            code: ${error.errorCode}
            description: ${error.description}
            errorType: ${error.errorType}
            isForMainFrame: ${error.isForMainFrame}
            ''');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    _handleCameraPermission();
  }

  Future<void> _handleCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (!status.isGranted) {
      print('Camera permission denied');
      // Handle denied permission case
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biometria"),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}