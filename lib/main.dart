import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:passaqui/src/core/app_theme.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/welcome/welcome_screen.dart';

void main() {
  DIService().init();

  runApp(MaterialApp(
    theme: AppTheme.appTheme,
    navigatorKey: DIService().inject<NavigationHandler>().getGlobalKey(),
    onGenerateRoute: DIService().inject<NavigationHandler>().routes,
    initialRoute: WelcomeScreen.route,
    localizationsDelegates: [GlobalMaterialLocalizations.delegate],
    supportedLocales: [
      const Locale('pt', 'BR'),
    ],
  ));
}
