
import 'package:flutter/material.dart';
import 'package:passaqui/src/core/app_theme.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';

class PassaquiApp extends StatefulWidget {
  const PassaquiApp({super.key});

  @override
  State<PassaquiApp> createState() => _PassaquiAppState();
}

class _PassaquiAppState extends State<PassaquiApp> {

  final NavigationHandler _navigationHandler = DIService().inject<NavigationHandler>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationHandler.getGlobalKey(),
      onGenerateRoute: _navigationHandler.routes,
      title: 'Passaqui',
      theme: AppTheme.appTheme,
      initialRoute: LoginScreen.route,
    );
  }
}