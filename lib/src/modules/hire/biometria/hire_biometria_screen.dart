import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HireBiometriaScreen extends StatefulWidget {
  static const String route = "/hire-biometria";
  final String? url;

  const HireBiometriaScreen({required this.url, Key? key}) : super(key: key);

  @override
  State<HireBiometriaScreen> createState() => _HireBiometriaScreenState();
}

class _HireBiometriaScreenState extends State<HireBiometriaScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
    controller = WebViewController()
    ..setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) {
      }
    ))
      ..loadRequest(
        Uri.parse('${widget.url}')
      )
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  Future<void> _requestCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      print("Camera permission granted");
    } else {
      print("Camera permission not granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PassaquiAppBar(
        title:'Retornar para o app',
        showBackButton: true,
        showLogo: false,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}



