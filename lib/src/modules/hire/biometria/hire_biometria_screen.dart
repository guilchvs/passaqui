// // import 'package:flutter/material.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:passaqui/src/shared/widget/appbar.dart';
// //
// // import '../../../core/di/service_locator.dart';
// // import '../../../core/navigation/navigation_handler.dart';
// //
// // class HireBiometriaScreen extends StatefulWidget {
// //   static const String route = "/hire-biometria";
// //   final String url;
// //
// //   const HireBiometriaScreen({required this.url, Key? key}) : super(key: key);
// //
// //   @override
// //   State<HireBiometriaScreen> createState() => _HireBiometriaScreenState();
// // }
// //
// // class _HireBiometriaScreenState extends State<HireBiometriaScreen> {
// //   InAppWebViewController? _webViewController;
// //   bool _cameraPermissionGranted = false;
// //   final NavigationHandler? navigationHandler = DIService().inject<NavigationHandler>(); // Replace with your DI service logic
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _requestCameraPermission().then((granted) {
// //       setState(() {
// //         _cameraPermissionGranted = granted;
// //       });
// //     });
// //   }
// //
// //   Future<bool> _requestCameraPermission() async {
// //     var status = await Permission.camera.request();
// //     return status.isGranted;
// //   }
// //
// //   void _loadWebView() {
// //     if (_webViewController != null && widget.url.isNotEmpty) {
// //       _webViewController!.loadUrl(
// //         urlRequest: URLRequest(url: WebUri(widget.url)),
// //       );
// //     } else {
// //       print("WebViewController or URL is null/empty");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: PassaquiAppBar(
// //         title: 'Prosseguir',
// //         showLogo: false,
// //         showBackButton: true,
// //         navigationHandler: navigationHandler,
// //
// //       ),
// //       body: _cameraPermissionGranted
// //           ? InAppWebView(
// //         initialUrlRequest: URLRequest(
// //           url: WebUri(widget.url),
// //         ),
// //         initialOptions: InAppWebViewGroupOptions(
// //           crossPlatform: InAppWebViewOptions(
// //             javaScriptEnabled: true,
// //             useShouldOverrideUrlLoading: true,
// //             mediaPlaybackRequiresUserGesture: false,
// //           ),
// //           android: AndroidInAppWebViewOptions(
// //             useHybridComposition: true,
// //           ),
// //           ios: IOSInAppWebViewOptions(
// //             allowsInlineMediaPlayback: true,
// //           ),
// //         ),
// //         onWebViewCreated: (controller) {
// //           _webViewController = controller;
// //           _loadWebView(); // Load the WebView after it is created
// //         },
// //         onLoadStart: (controller, url) {
// //           print("WebView is loading: $url");
// //         },
// //         onLoadStop: (controller, url) {
// //           print("WebView loaded: $url");
// //         },
// //         onLoadError: (controller, url, code, message) {
// //           print("WebView error - URL: $url, Error: $message");
// //         },
// //         androidOnPermissionRequest: (controller, origin, resources) async {
// //           print("Permission request for resources: $resources");
// //           return PermissionRequestResponse(
// //             resources: resources,
// //             action: PermissionRequestResponseAction.GRANT,
// //           );
// //         },
// //       )
// //           : Center(child: Text('Camera permission not granted.')),
// //     );
// //   }
// // }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:passaqui/src/shared/widget/appbar.dart';
// //
// // import '../../../core/di/service_locator.dart';
// // import '../../../core/navigation/navigation_handler.dart';
// //
// // class HireBiometriaScreen extends StatefulWidget {
// //   static const String route = "/hire-biometria";
// //   final String url;
// //
// //   const HireBiometriaScreen({required this.url, Key? key}) : super(key: key);
// //
// //   @override
// //   State<HireBiometriaScreen> createState() => _HireBiometriaScreenState();
// // }
// //
// // class _HireBiometriaScreenState extends State<HireBiometriaScreen> {
// //   InAppWebViewController? _webViewController;
// //   bool _cameraPermissionGranted = false;
// //   final NavigationHandler? navigationHandler = DIService().inject<NavigationHandler>();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _requestCameraPermission().then((granted) {
// //       setState(() {
// //         _cameraPermissionGranted = granted;
// //       });
// //     });
// //   }
// //
// //   Future<bool> _requestCameraPermission() async {
// //     var status = await Permission.camera.request();
// //     return status.isGranted;
// //   }
// //
// //   void _loadWebView() {
// //     if (_webViewController != null && widget.url.isNotEmpty) {
// //       _webViewController!.loadUrl(
// //         urlRequest: URLRequest(url: WebUri(widget.url)),
// //       );
// //     } else {
// //       print("WebViewController or URL is null/empty");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: <Widget>[
// //           Expanded(
// //             child: _cameraPermissionGranted
// //                 ? InAppWebView(
// //               initialUrlRequest: URLRequest(
// //                 url: WebUri(widget.url),
// //               ),
// //               initialOptions: InAppWebViewGroupOptions(
// //                 crossPlatform: InAppWebViewOptions(
// //                   javaScriptEnabled: true,
// //                   useShouldOverrideUrlLoading: true,
// //                   mediaPlaybackRequiresUserGesture: false,
// //                 ),
// //                 android: AndroidInAppWebViewOptions(
// //                   useHybridComposition: true,
// //                 ),
// //                 ios: IOSInAppWebViewOptions(
// //                   allowsInlineMediaPlayback: true,
// //                 ),
// //               ),
// //               onWebViewCreated: (controller) {
// //                 _webViewController = controller;
// //                 _loadWebView(); // Load the WebView after it is created
// //               },
// //               onLoadStart: (controller, url) {
// //                 print("WebView is loading: $url");
// //               },
// //               onLoadStop: (controller, url) {
// //                 print("WebView loaded: $url");
// //               },
// //               onLoadError: (controller, url, code, message) {
// //                 print("WebView error - URL: $url, Error: $message");
// //               },
// //               androidOnPermissionRequest: (controller, origin, resources) async {
// //                 print("Permission request for resources: $resources");
// //                 return PermissionRequestResponse(
// //                   resources: resources,
// //                   action: PermissionRequestResponseAction.GRANT,
// //                 );
// //               },
// //             )
// //                 : Center(child: Text('Camera permission not granted.')),
// //           ),
// //           PassaquiAppBar(
// //             title: 'Prosseguir',
// //             showLogo: false,
// //             showBackButton: false,
// //             navigationHandler: navigationHandler,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:passaqui/src/modules/biometria/wait/biometria_wait_screen.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../../core/di/service_locator.dart';
// import '../../../core/navigation/navigation_handler.dart';
// import '../../../services/biometria_service.dart';
// import '../../../shared/widget/button.dart';
//
// class HireBiometriaScreen extends StatefulWidget {
//   static const String route = "/hire-biometria";
//   final String url;
//
//   const HireBiometriaScreen({required this.url, Key? key}) : super(key: key);
//
//   @override
//   State<HireBiometriaScreen> createState() => _HireBiometriaScreenState();
// }
//
// class _HireBiometriaScreenState extends State<HireBiometriaScreen> {
//   InAppWebViewController? _webViewController;
//   bool _cameraPermissionGranted = false;
//   final NavigationHandler? navigationHandler = DIService().inject<NavigationHandler>();
//   late Timer _timer;
//   int _biometriaResult = 0;
//   final BiometriaService _biometriaService = DIService().inject<BiometriaService>();
//
//
//   void fetchBiometriaData() async {
//     _biometriaResult = await _biometriaService.fetchBiometriaData();
//     print('Biometria Result: $_biometriaResult'); // Print the fetched result
//
//     // if (_biometriaResult == 1) {
//     //   DIService().inject<NavigationHandler>().navigate(BiometriaErrorScreen.route);
//     //   _timer.cancel(); // Stop timer once valid result is received
//     // } else if (_biometriaResult == 2) {
//     //   DIService().inject<NavigationHandler>().navigate(BiometriaSucessScreen.route);
//     //   _timer.cancel(); // Stop timer once valid result is received
//     // }
//     // If result is neither 1 nor 2, do nothing and continue calling fetchBiometriaData()
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _requestCameraPermission().then((granted) {
//       setState(() {
//         _cameraPermissionGranted = granted;
//       });
//     });
//
//     _timer = Timer.periodic(Duration(seconds: 5), (timer) {
//       print("Fetching API every 5 seconds!");
//       fetchBiometriaData();
//     });
//   }
//
//   @override
//   void dispose(){
//     _timer.cancel();
//     super.dispose();
//   }
//
//   Future<bool> _requestCameraPermission() async {
//     var status = await Permission.camera.request();
//     return status.isGranted;
//   }
//
//   void _loadWebView() {
//     if (_webViewController != null && widget.url.isNotEmpty) {
//       _webViewController!.loadUrl(
//         urlRequest: URLRequest(url: WebUri(widget.url)),
//       );
//     } else {
//       print("WebViewController or URL is null/empty");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: _cameraPermissionGranted
//                 ? InAppWebView(
//               initialUrlRequest: URLRequest(
//                 url: WebUri(widget.url),
//               ),
//               initialOptions: InAppWebViewGroupOptions(
//                 crossPlatform: InAppWebViewOptions(
//                   javaScriptEnabled: true,
//                   useShouldOverrideUrlLoading: true,
//                   mediaPlaybackRequiresUserGesture: false,
//                 ),
//                 android: AndroidInAppWebViewOptions(
//                   useHybridComposition: true,
//                 ),
//                 ios: IOSInAppWebViewOptions(
//                   allowsInlineMediaPlayback: true,
//                 ),
//               ),
//               onWebViewCreated: (controller) {
//                 _webViewController = controller;
//                 _loadWebView(); // Load the WebView after it is created
//               },
//               onLoadStart: (controller, url) {
//                 print("WebView is loading: $url");
//               },
//               onLoadStop: (controller, url) {
//                 print("WebView loaded: $url");
//               },
//               onLoadError: (controller, url, code, message) {
//                 print("WebView error - URL: $url, Error: $message");
//               },
//               androidOnPermissionRequest: (controller, origin, resources) async {
//                 print("Permission request for resources: $resources");
//                 return PermissionRequestResponse(
//                   resources: resources,
//                   action: PermissionRequestResponseAction.GRANT,
//                 );
//               },
//             )
//                 : Center(child: Text('Camera permission not granted.')),
//           ),
//           CustomBottomBar(
//             navigationHandler: navigationHandler,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CustomBottomBar extends StatelessWidget {
//   final NavigationHandler? navigationHandler;
//
//   const CustomBottomBar({Key? key, this.navigationHandler}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Color(0xFF136048),
//       height: 80,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 82.0),
//               child: PassaquiButton(
//                 style: PassaquiButtonStyle.defaultLight,
//                 label: 'Prosseguir',
//                 height: 44,
//                 centerText: true,
//                 onTap: () {
//                   DIService().inject<NavigationHandler>().navigate(BiometriaWaitScreen.route);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:passaqui/src/modules/biometria/wait/biometria_wait_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import '../../../services/biometria_service.dart';
import '../../../shared/widget/button.dart';

class HireBiometriaScreen extends StatefulWidget {
  static const String route = "/hire-biometria";
  final String url;

  const HireBiometriaScreen({required this.url, Key? key}) : super(key: key);

  @override
  State<HireBiometriaScreen> createState() => _HireBiometriaScreenState();
}

class _HireBiometriaScreenState extends State<HireBiometriaScreen> {
  InAppWebViewController? _webViewController;
  bool _cameraPermissionGranted = false;
  final NavigationHandler? navigationHandler =
      DIService().inject<NavigationHandler>();
  int _biometriaResult = 0;
  final BiometriaService _biometriaService =
      DIService().inject<BiometriaService>();

  void fetchBiometriaData() async {
    _biometriaResult = await _biometriaService.fetchBiometriaData();
    print('Biometria Result: $_biometriaResult'); // Print the fetched result

// if (_biometriaResult == 1) {
//   DIService().inject<NavigationHandler>().navigate(BiometriaErrorScreen.route);
//   _timer.cancel(); // Stop timer once valid result is received
// } else if (_biometriaResult == 2) {
//   DIService().inject<NavigationHandler>().navigate(BiometriaSucessScreen.route);
//   _timer.cancel(); // Stop timer once valid result is received
// }
// If result is neither 1 nor 2, do nothing and continue calling fetchBiometriaData()
  }

  @override
  void initState() {
    super.initState();
    _requestCameraPermission().then((granted) {
      setState(() {
        _cameraPermissionGranted = granted;
      });
    });
  }

  Future<bool> _requestCameraPermission() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  void _loadWebView() {
    if (_webViewController != null && widget.url.isNotEmpty) {
      _webViewController!.loadUrl(
        urlRequest: URLRequest(url: WebUri(widget.url)),
      );
    } else {
      print("WebViewController or URL is null/empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomBottomBar(
            navigationHandler: navigationHandler,
          ),
          Expanded(
            child: _cameraPermissionGranted
                ? InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: WebUri(widget.url),
                    ),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        javaScriptEnabled: true,
                        useShouldOverrideUrlLoading: true,
                        mediaPlaybackRequiresUserGesture: false,
                      ),
                      android: AndroidInAppWebViewOptions(
                        useHybridComposition: true,
                      ),
                      ios: IOSInAppWebViewOptions(
                        allowsInlineMediaPlayback: true,
                      ),
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                      _loadWebView(); // Load the WebView after it is created
                    },
                    onLoadStart: (controller, url) {
                      print("WebView is loading: $url");
                    },
                    onLoadStop: (controller, url) {
                      print("WebView loaded: $url");
                    },
                    onLoadError: (controller, url, code, message) {
                      print("WebView error - URL: $url, Error: $message");
                    },
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      print("Permission request for resources: $resources");
                      return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT,
                      );
                    },
                  )
                : Center(child: Text('Camera permission not granted.')),
          ),
          // CustomBottomBar(
          //   navigationHandler: navigationHandler,
          // ),
        ],
      ),
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  final NavigationHandler? navigationHandler;

  const CustomBottomBar({Key? key, this.navigationHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF136048),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 82.0, right: 82, top: 24),
              child: PassaquiButton(
                style: PassaquiButtonStyle.defaultLight,
                label: 'Prosseguir',
                height: 44,
                centerText: true,
                onTap: () {
                  DIService()
                      .inject<NavigationHandler>()
                      .navigate(BiometriaWaitScreen.route);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
