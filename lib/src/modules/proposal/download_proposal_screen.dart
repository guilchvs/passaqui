// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:http/http.dart' as http;
// import 'package:passaqui/src/core/di/service_locator.dart';
// import 'package:passaqui/src/services/auth_service.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
//
// class DownloadProposalScreen extends StatefulWidget {
//   static const String route = "/download-proposal";
//
//   const DownloadProposalScreen({super.key});
//
//   @override
//   State<DownloadProposalScreen> createState() => _DownloadProposalScreenState();
// }
//
// class _DownloadProposalScreenState extends State<DownloadProposalScreen> {
//   bool _isDownloading = false;
//   final AuthService _authService = DIService().inject<AuthService>();
//
//   Future<void> downloadFile(String url, String filename) async {
//     final token = await _authService.getToken();
//
//     setState(() {
//       _isDownloading = true;
//     });
//
//     try {
//       // Make the HTTP GET request with authorization header
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         // Get the temporary directory of the device
//         final directory = await getTemporaryDirectory();
//         final file = File('${directory.path}/$filename');
//
//         // Write the response body to the file
//         await file.writeAsBytes(response.bodyBytes);
//
//         print('File downloaded to ${file.path}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('File downloaded to ${file.path}')),
//         );
//       } else {
//         print('Failed to download file: ${response.statusCode}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to download file: ${response.statusCode}')),
//         );
//       }
//     } catch (e) {
//       print('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     } finally {
//       setState(() {
//         _isDownloading = false;
//       });
//     }
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.white),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//             Expanded(
//               child: SvgPicture.asset(
//                 'assets/images/receive-money.svg', // Replace with your SVG asset path
//                 height: 300, // Adjust the height as needed
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(bottom: 22.0),
//               child: Text(
//                 'Agora falta pouco!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                   height: 1.5,
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Em instantes, você receberá seu contrato pelo e-mail cadastrado!\n\n Caso deseje fazer o download do mesmo, clique em Baixar Contrato.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.white,
//                   height: 1.5,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 200),
//                     child: PassaquiButton(
//                       label: _isDownloading ? "Baixando contrato!" : "Baixar Contrato",
//                       centerText: true,
//                       minimumSize: const Size(200, 40),
//                       style: PassaquiButtonStyle.defaultLight,
//                       onTap: _isDownloading
//                           ? null
//                           : () {
//                         //const url = 'https://example.com/file.pdf'; // Replace with your endpoint
//                         const url = 'http://passcash-api-hml.us-east-1.elasticbeanstalk.com/api/ApiMaster/downloadCCB'; // Replace with your endpoint
//                         const filename = 'contract.pdf';
//                         downloadFile(url, filename);
//                       },
//                     ),
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

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:passaqui/src/core/di/service_locator.dart';
// import 'package:passaqui/src/services/auth_service.dart';
// import 'package:passaqui/src/shared/widget/button.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class DownloadProposalScreen extends StatefulWidget {
//   static const String route = "/download-proposal";
//
//   const DownloadProposalScreen({super.key});
//
//   @override
//   State<DownloadProposalScreen> createState() => _DownloadProposalScreenState();
// }
//
// class _DownloadProposalScreenState extends State<DownloadProposalScreen> {
//   bool _isDownloading = false;
//   final AuthService _authService = DIService().inject<AuthService>();
//
//   Future<void> downloadFile(String url, String filename) async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.storage,
//     ].request();
//     print(statuses[Permission.storage]);
//
//     final token = await _authService.getToken();
//
//     if (statuses[Permission.storage] == PermissionStatus.granted) {
//       //
//       setState(() {
//         _isDownloading = true;
//       });
//       try {
//         final response = await http.get(
//           Uri.parse(url),
//           headers: {
//             HttpHeaders.authorizationHeader: 'Bearer $token',
//           },
//         );
//
//         if (response.statusCode == 200) {
//           Directory? downloadsDirectory;
//           if (Platform.isAndroid) {
//             downloadsDirectory = await getExternalStorageDirectory();
//           } else {
//             downloadsDirectory = await getApplicationDocumentsDirectory();
//           }
//
//           final file = File('/storage/emulated/0/$filename');
//           // final directory = await getTemporaryDirectory();
//           // final file = File('${directory.path}/$filename');
//
//           await file.writeAsBytes(response.bodyBytes);
//
//           print('File downloaded to ${file.path}');
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('File downloaded to ${file.path}')),
//           );
//         } else {
//           print('Failed to download file: ${response.statusCode}');
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//                 content:
//                     Text('Failed to download file: ${response.statusCode}')),
//           );
//         }
//       } catch (e) {
//         print('Error: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       } finally {
//         setState(() {
//           _isDownloading = false;
//         });
//       }
//       //
//     } else {
//       bool isPermanentlyDenied = await Permission.storage.isPermanentlyDenied;
//       if (isPermanentlyDenied) {
//         await AlertDialog(
//             title: Text('Permissão negada'),
//             content:
//                 Text('Acesse as configurações para poder baixar o boleto'));
//         openAppSettings();
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.white),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//             Expanded(
//               child: SvgPicture.asset(
//                 'assets/images/receive-money.svg',
//                 // Replace with your SVG asset path
//                 height: 300, // Adjust the height as needed
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(bottom: 22.0),
//               child: Text(
//                 'Agora falta pouco!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                   height: 1.5,
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Em instantes, você receberá seu contrato pelo e-mail cadastrado!\n\n Caso deseje fazer o download do mesmo, clique em Baixar Contrato.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.white,
//                   height: 1.5,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 200),
//                     child: PassaquiButton(
//                       label: _isDownloading
//                           ? "Baixando contrato!"
//                           : "Baixar Contrato",
//                       centerText: true,
//                       minimumSize: const Size(200, 40),
//                       style: PassaquiButtonStyle.defaultLight,
//                       onTap: _isDownloading
//                           ? null
//                           : () {
//                               //const url = 'https://example.com/file.pdf'; // Replace with your endpoint
//                               const url =
//                                   'http://passcash-api-hml.us-east-1.elasticbeanstalk.com/api/ApiMaster/downloadCCB'; // Replace with your endpoint
//                               const filename = 'contract.pdf';
//                               downloadFile(url, filename);
//                             },
//                     ),
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


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/services/auth_service.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class DownloadProposalScreen extends StatefulWidget {
  static const String route = "/download-proposal";

  const DownloadProposalScreen({super.key});

  @override
  State<DownloadProposalScreen> createState() => _DownloadProposalScreenState();
}

class _DownloadProposalScreenState extends State<DownloadProposalScreen> {
  bool _isDownloading = false;
  final AuthService _authService = DIService().inject<AuthService>();

  Future<bool> _requestStoragePermission() async {
    var status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> downloadFile(String url, String filename) async {
    // Request permission
    var status = await Permission.storage.request();
    if (status.isGranted) {
      setState(() {
        _isDownloading = true;
      });

      try {
        final token = await _authService.getToken();

        final response = await http.get(
          Uri.parse(url),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          Directory? downloadsDirectory;
          if (Platform.isAndroid) {
            downloadsDirectory = await getExternalStorageDirectory();
          } else {
            downloadsDirectory = await getApplicationDocumentsDirectory();
          }

          final file = File('${downloadsDirectory!.path}/$filename');
          await file.writeAsBytes(response.bodyBytes);

          print('File downloaded to ${file.path}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File downloaded to ${file.path}')),
          );
        } else {
          print('Failed to download file: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                Text('Failed to download file: ${response.statusCode}')),
          );
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isDownloading = false;
        });
      }
    } else {
      // Handle denied or permanently denied status
      if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Permissão de armazenamento negada.'),
          ),
        );
      } else if (status.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Permissão de armazenamento permanentemente negada. Abra as configurações do dispositivo para conceder permissão.'),
            action: SnackBarAction(
              label: 'Abrir Configurações',
              onPressed: openAppSettings,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: SvgPicture.asset(
                'assets/images/receive-money.svg',
                // Replace with your SVG asset path
                height: 300, // Adjust the height as needed
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 22.0),
              child: Text(
                'Agora falta pouco!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Em instantes, você receberá seu contrato pelo e-mail cadastrado!\n\n Caso deseje fazer o download do mesmo, clique em Baixar Contrato.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 200),
                    child: PassaquiButton(
                      label: _isDownloading
                          ? "Baixando contrato!"
                          : "Baixar Contrato",
                      centerText: true,
                      minimumSize: const Size(200, 40),
                      style: PassaquiButtonStyle.defaultLight,
                      onTap: _isDownloading
                          ? null
                          : () {
                        const url =
                            'http://passcash-api-hml.us-east-1.elasticbeanstalk.com/api/ApiMaster/downloadCCB'; // Replace with your endpoint
                        const filename = 'contract.pdf';
                        downloadFile(url, filename);
                      },
                    ),
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
