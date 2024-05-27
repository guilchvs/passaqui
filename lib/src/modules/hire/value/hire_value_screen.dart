import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/core/app_theme.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/modules/withdraw/welcome/withdraw_welcome_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';
import 'package:passaqui/src/shared/widget/text_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HireValueScreen extends StatefulWidget {
  static const String route = "/hire-value";

  const HireValueScreen({super.key});

  @override
  State<HireValueScreen> createState() => _HireValueScreenState();
}

class _HireValueScreenState extends State<HireValueScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(),
      backgroundColor: Color.fromRGBO(18, 96, 73, 1),
      body: Stack(
        children: [

        ],
      ),
    );
  }
}

