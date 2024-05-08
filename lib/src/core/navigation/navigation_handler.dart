import 'package:flutter/material.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';

class NavigationHandler {
  GlobalKey<NavigatorState> _globalKey = GlobalKey();
  GlobalKey<NavigatorState> getGlobalKey() => _globalKey;


  Route<dynamic>? routes(RouteSettings settings){
    switch(settings.name){
      case LoginScreen.route:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
    }
    return null;
  }
}
