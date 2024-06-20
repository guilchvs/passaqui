// import 'package:flutter/material.dart';
// import 'package:passaqui/src/services/auth_service.dart'; // Adjust the import path as per your project structure
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:passaqui/src/shared/widget/text_field.dart';
//
// import '../../../core/di/service_locator.dart';
// import '../../../core/navigation/navigation_handler.dart';
// import '../success/success_screen.dart';
//
// class CreateAccountScreen extends StatefulWidget {
//   static const String route = "/create-account";
//
//   const CreateAccountScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CreateAccountScreen> createState() => _CreateAccountScreenState();
// }
//
// class _CreateAccountScreenState extends State<CreateAccountScreen> {
//   late PageController _pageController;
//   int _currentPageIndex = 0;
//
//   late List<TextEditingController> controllers;
//   List<String> labels = [
//     "Bem vindo ao PassAqui!\n\nPara começar precisamos de algumas informações. Será rápido e fácil.",
//     "Agora nos informe sua senha:",
//     "Informe sua senha novamente:",
//     "Insira seu CPF no campo abaixo:",
//     "Agora informe seu telefone:",
//     "Por favor, insira sua data de nascimento",
//     "Estamos quase finalizando.\n\nInforme seu e-mail no campo abaixo:",
//     "Agora precisamos do seu RG:",
//     "Agora entramos na etapa sobre sua residência.\n\nPedimos que insira seu CEP:",
//     "Insira abaixo o nome do logradouro, por favor:",
//     "Agora informe o número da sua residência:",
//     "Para terminar, informe (se necessário) o complemento da localização de sua residência:"
//   ];
//
//   List<String> placeholders = [
//     "Digite seu nome completo",
//     "Digite sua senha",
//     "Digite sua senha novamente",
//     "Digite seu CPF",
//     "Digite seu telefone",
//     "Data nascimento",
//     "Digite seu e-mail",
//     "Digite seu RG",
//     "Digite seu CEP",
//     "Digite seu logradouro",
//     "Digite seu número",
//     "Digite o complemento",
//   ];
//
//   final AuthService _authService = AuthService();
//
//   @override
//   void initState() {
//     _pageController = PageController();
//     controllers =
//         List.generate(labels.length, (index) => TextEditingController());
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     controllers.forEach((controller) => controller.dispose());
//     super.dispose();
//   }
//
//   void nextPage() {
//     if (_currentPageIndex < labels.length - 1) {
//       _pageController.nextPage(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//       setState(() {
//         _currentPageIndex++;
//       });
//     } else {
//       _registerAccount();
//     }
//   }
//
//   Future<void> _registerAccount() async {
//     try {
//       final response = await _authService.register(
//         email: controllers[6].text.trim(),
//         name: controllers[0].text.trim(),
//         password: controllers[1].text.trim(),
//         confirmPassword: controllers[2].text.trim(),
//         cpf: controllers[3].text.trim(),
//         telefone: controllers[4].text.trim(),
//         cep: controllers[8].text.trim(),
//         logradouro: controllers[9].text.trim(),
//         numeroLogradouro: int.tryParse(controllers[10].text.trim()) ?? 0,
//         complemento: controllers[11].text.trim(),
//         dataNascimento: _formatDate(controllers[5].text.trim()),
//         rg: controllers[7].text.trim(),
//       );
//
//       if (response.statusCode == 200) {
//         print('Account registered successfully');
//         DIService().inject<NavigationHandler>().navigate(SuccessScreen.route);
//       } else {
//         throw Exception('Failed to register account: ${response.body}');
//       }
//     } catch (e) {
//       print('Error registering account: $e');
//       // Handle error, show error message or retry logic
//     }
//   }
//
//   String _formatDate(String date) {
//     List<String> parts = date.split('/');
//     if (parts.length == 3) {
//       return '${parts[2]}-${parts[1]}-${parts[0]}';
//     }
//     return date; // Return original if format cannot be determined
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[50],
//         elevation: 0,
//         automaticallyImplyLeading: false, // Hide back button
//       ),
//       resizeToAvoidBottomInset: true, // Ensure resizing when keyboard appears
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             LinearProgressIndicator(
//               value: (_currentPageIndex + 1) / labels.length,
//               valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFFA8CA4B)),
//               backgroundColor: Colors.grey[50],
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight,
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: labels.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 32),
//                         // Use RichText to style specific substrings with bold font weight
//                         if (labels[index].startsWith("Bem vindo ao PassAqui!")) ...[
//                           RichText(
//                             text: TextSpan(
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: 'Bem vindo ao PassAqui!',
//                                   style: TextStyle(fontWeight: FontWeight.w600),
//                                 ),
//                                 TextSpan(
//                                   text: labels[index].substring("Bem vindo ao PassAqui!".length),
//                                   style: TextStyle(fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ] else if (labels[index].contains("Estamos quase finalizando.")) ...[
//                           RichText(
//                             text: TextSpan(
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: 'Estamos quase finalizando.',
//                                   style: TextStyle(fontWeight: FontWeight.w600),
//                                 ),
//                                 TextSpan(
//                                   text: labels[index].substring("Estamos quase finalizando.".length),
//                                   style: TextStyle(fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ] else if (labels[index].contains("Agora entramos na etapa sobre sua residência.")) ...[
//                           RichText(
//                             text: TextSpan(
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: 'Agora entramos na etapa sobre sua residência.',
//                                   style: TextStyle(fontWeight: FontWeight.w600),
//                                 ),
//                                 TextSpan(
//                                   text: labels[index].substring("Agora entramos na etapa sobre sua residência.".length),
//                                   style: TextStyle(fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ] else ...[
//                           RichText(
//                             text: TextSpan(
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: labels[index],
//                                   style: TextStyle(fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                         const SizedBox(height: 160),
//                         if (index == 5) // Check if it's the date of birth step
//                           GestureDetector(
//                             onTap: () async {
//                               final DateTime? picked = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(1900),
//                                 lastDate: DateTime.now(),
//                                 builder: (BuildContext context, Widget? child) {
//                                   return Theme(
//                                     data: ThemeData.light().copyWith(
//                                       colorScheme: ColorScheme.light(
//                                         primary: const Color(0xFFA8CA4B),
//                                         onPrimary: Colors.white,
//                                         surface: Colors.white,
//                                         onSurface: Colors.black, // Text color
//                                       ),
//                                       dialogBackgroundColor:
//                                       Colors.white, // Background color
//                                     ),
//                                     child: child!,
//                                   );
//                                 },
//                               );
//                               if (picked != null) {
//                                 String formattedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
//                                 setState(() {
//                                   controllers[index].text = formattedDate;
//                                 });
//                               }
//                             },
//                             child: AbsorbPointer(
//                               absorbing: true,
//                               // Absorb gestures to prevent user input
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 12, horizontal: 10),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: Colors.grey, width: 1.0),
//                                   borderRadius: BorderRadius.circular(5.0),
//                                   color: Colors.grey[200], // Placeholder color
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.calendar_today,
//                                         color: Colors.grey),
//                                     SizedBox(width: 10),
//                                     Text(
//                                       controllers[index].text.isEmpty
//                                           ? 'DD/MM/YYYY'
//                                           : controllers[index].text,
//                                       style: TextStyle(color: Colors.grey[600]),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//                         else // For other steps, show regular text field
//                           PassaquiTextField(
//                             editingController: controllers[index],
//                             placeholder: placeholders[index],
//                             textColor: Colors.black,
//                           ),
//                         const SizedBox(height: 40),
//                         const Spacer(),
//                         PassaquiButton(
//                           label: index == labels.length - 1
//                               ? "Continue"
//                               : "Continue",
//                           showArrow: true,
//                           minimumSize: Size(200, 40),
//                           onTap: nextPage,
//                         ),
//                         const SizedBox(height: 200),
//                       ],
//                     ),
//                   );
//                 },
//                 onPageChanged: (index) {
//                   setState(() {
//                     _currentPageIndex = index;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:passaqui/src/modules/welcome/welcome_screen.dart';
import 'package:passaqui/src/services/auth_service.dart'; // Adjust the import path as per your project structure
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/text_field.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import '../success/success_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String route = "/create-account";

  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  late List<TextEditingController> controllers;
  List<String> labels = [
    "Bem vindo ao PassAqui!\n\nPara começar precisamos de algumas informações. Será rápido e fácil.",
    "Agora nos informe sua senha:",
    "Informe sua senha novamente:",
    "Insira seu CPF no campo abaixo:",
    "Agora informe seu telefone:",
    "Por favor, insira sua data de nascimento",
    "Estamos quase finalizando.\n\nInforme seu e-mail no campo abaixo:",
    "Agora precisamos do seu RG:",
    "Agora entramos na etapa sobre sua residência.\n\nPedimos que insira seu CEP:",
    "Insira abaixo o nome do logradouro, por favor:",
    "Agora informe o número da sua residência:",
    "Para terminar, informe (se necessário) o complemento da localização de sua residência:"
  ];

  List<String> placeholders = [
    "Digite seu nome completo",
    "Digite sua senha",
    "Digite sua senha novamente",
    "Digite seu CPF",
    "Digite seu telefone",
    "Data nascimento",
    "Digite seu e-mail",
    "Digite seu RG",
    "Digite seu CEP",
    "Digite seu logradouro",
    "Digite seu número",
    "Digite o complemento",
  ];

  final AuthService _authService = AuthService();

  @override
  void initState() {
    _pageController = PageController();
    controllers =
        List.generate(labels.length, (index) => TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void nextPage() {
    if (_currentPageIndex < labels.length - 1) {
//      chamar funcao de validar cpf aqui
      if(isFieldValid) {
        print('CPF Valido');
      }else print('CPF invalido');
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPageIndex++;
      });
    } else {
      _registerAccount();
    }
  }

  void previousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPageIndex--;
      });
    }
  }

  void navigateToWelcomeScreen() {
    DIService().inject<NavigationHandler>().navigate(WelcomeScreen.route);
  }

  Future<void> _registerAccount() async {
    try {
      final response = await _authService.register(
        email: controllers[6].text.trim(),
        name: controllers[0].text.trim(),
        password: controllers[1].text.trim(),
        confirmPassword: controllers[2].text.trim(),
        cpf: controllers[3].text.trim(),
        telefone: controllers[4].text.trim(),
        cep: controllers[8].text.trim(),
        logradouro: controllers[9].text.trim(),
        numeroLogradouro: int.tryParse(controllers[10].text.trim()) ?? 0,
        complemento: controllers[11].text.trim(),
        dataNascimento: _formatDate(controllers[5].text.trim()),
        rg: controllers[7].text.trim(),
      );

      if (response.statusCode == 200) {
        print('Account registered successfully');
        DIService().inject<NavigationHandler>().navigate(SuccessScreen.route);
      } else {
        throw Exception('Failed to register account: ${response.body}');
      }
    } catch (e) {
      print('Error registering account: $e');
      // Handle error, show error message or retry logic
    }
  }

  String _formatDate(String date) {
    List<String> parts = date.split('/');
    if (parts.length == 3) {
      return '${parts[2]}-${parts[1]}-${parts[0]}';
    }
    return date; // Return original if format cannot be determined
  }
  
// colocar validacoes de campos aqui, cpf, email, senha  
  bool _isFieldValid() {
    if (_currentPageIndex == 3) {
      print('entrou na funcao');      
      return CPFValidator.isValid(controllers[3].text.trim());
    }
    else return true;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        automaticallyImplyLeading: false,
        // Hide back button
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          color: const Color(0xFFA8CA4B),
          onPressed: previousPage,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            color: const Color(0xFFA8CA4B),
            onPressed: navigateToWelcomeScreen,
          ),
        ],
      ),
      resizeToAvoidBottomInset: true, // Ensure resizing when keyboard appears
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (_currentPageIndex + 1) / labels.length,
              valueColor:
                  AlwaysStoppedAnimation<Color>(const Color(0xFFA8CA4B)),
              backgroundColor: Colors.grey[50],
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  kBottomNavigationBarHeight,
              child: PageView.builder(
                controller: _pageController,
                itemCount: labels.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32),
                        // Use RichText to style specific substrings with bold font weight
                        if (labels[index]
                            .startsWith("Bem vindo ao PassAqui!")) ...[
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Bem vindo ao PassAqui!',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: labels[index].substring(
                                      "Bem vindo ao PassAqui!".length),
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ] else if (labels[index]
                            .contains("Estamos quase finalizando.")) ...[
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Estamos quase finalizando.',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: labels[index].substring(
                                      "Estamos quase finalizando.".length),
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ] else if (labels[index].contains(
                            "Agora entramos na etapa sobre sua residência.")) ...[
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'Agora entramos na etapa sobre sua residência.',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: labels[index].substring(
                                      "Agora entramos na etapa sobre sua residência."
                                          .length),
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: labels[index],
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 160),
                        if (index == 5) // Check if it's the date of birth step
                          GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: const Color(0xFFA8CA4B),
                                        onPrimary: Colors.white,
                                        surface: Colors.white,
                                        onSurface: Colors.black, // Text color
                                      ),
                                      dialogBackgroundColor:
                                          Colors.white, // Background color
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (picked != null) {
                                String formattedDate =
                                    "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                                setState(() {
                                  controllers[index].text = formattedDate;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              absorbing: true,
                              // Absorb gestures to prevent user input
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.grey[200], // Placeholder color
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                        color: Colors.grey),
                                    SizedBox(width: 10),
                                    Text(
                                      controllers[index].text.isEmpty
                                          ? 'DD/MM/YYYY'
                                          : controllers[index].text,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        else // For other steps, show regular text field
                          ((index == 1 || index == 2))
                              ? PassaquiTextField(
                                  editingController: controllers[index],
                                  placeholder: placeholders[index],
                                  textColor: Colors.black,
                                  isVisible: false)
                              : PassaquiTextField(
                                  editingController: controllers[index],
                                  placeholder: placeholders[index],
                                  textColor: Colors.black,
                                  isVisible: true,
                                ),
                        const SizedBox(height: 40),
                        const Spacer(),
                        PassaquiButton(
                          label: index == labels.length - 1
                              ? "Continue"
                              : "Continue",
                          showArrow: true,
                          minimumSize: Size(200, 40),
                          onTap: nextPage,
                        ),
                        const SizedBox(height: 200),
                      ],
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
