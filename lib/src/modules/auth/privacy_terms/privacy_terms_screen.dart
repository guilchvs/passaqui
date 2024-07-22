import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import '../../../shared/widget/button.dart';
import '../create-account/create_account_screen.dart';

class PrivacyTermsScreen extends StatefulWidget {
  static const String route = "/privacy-terms";

  const PrivacyTermsScreen({super.key});

  @override
  State<PrivacyTermsScreen> createState() => _PrivacyTermsScreenState();
}

class _PrivacyTermsScreenState extends State<PrivacyTermsScreen> {
  late PdfViewerController _pdfViewerController;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pdfViewerController.zoomLevel = 1.5; // 150% zoom level
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const PassaquiAppBar(
      //   showLogo: false,
      //   showBackButton: false,
      // ),
      backgroundColor: Color.fromRGBO(18, 96, 73, 1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 56.0, bottom: 22),
            child: Text(
              'Termos de privacidade',
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: SfPdfViewer.asset(
              'assets/pdf/terms_privacy.pdf',
              controller: _pdfViewerController,
              canShowScrollStatus: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  activeColor: Color(0xFFA8CA4B),
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    'Li e Aceito os Termos de Privacidade',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: PassaquiButton(
              disabled: !_isChecked, // Enable or disable based on _isChecked
              style: PassaquiButtonStyle.invertedPrimary,
              centerText: true,
              label: 'Prosseguir',
              onTap: _isChecked
                  ? _proceed
                  : null,
            ),
          )
        ],
      ),
    );
  }

  void _proceed() {
    DIService()
        .inject<NavigationHandler>()
        .navigate(CreateAccountScreen.route);
  }
}
