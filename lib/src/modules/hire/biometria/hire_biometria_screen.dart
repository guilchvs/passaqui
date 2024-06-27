import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HireBiometriaScreen extends StatefulWidget {
  static const String route = "/hire-biometria";
  final String? cpf;

  const HireBiometriaScreen({required this.cpf, Key? key}) : super(key: key);

  @override
  State<HireBiometriaScreen> createState() => _HireBiometriaScreenState();
}

class _HireBiometriaScreenState extends State<HireBiometriaScreen> {
  late final WebViewController controller;
  final String baseUrl =
      'http://passcash-api-hml.us-east-1.elasticbeanstalk.com';

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
          Uri.parse('$baseUrl/api/ApiMaster/iniciarBiometria?cpf=${widget.cpf}')
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PassaquiAppBar(
        title:'Flutter WebView',
        showBackButton: true,
        showLogo: false,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}