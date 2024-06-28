import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';

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
  final NavigationHandler? navigationHandler = DIService().inject<NavigationHandler>(); // Replace with your DI service logic

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
      appBar: PassaquiAppBar(
        title: 'Voltar para o app',
        showLogo: false,
        showBackButton: true,
        navigationHandler: navigationHandler,

      ),
      body: _cameraPermissionGranted
          ? InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(widget.url),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
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
        androidOnPermissionRequest: (controller, origin, resources) async {
          print("Permission request for resources: $resources");
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        },
      )
          : Center(child: Text('Camera permission not granted.')),
    );
  }
}
