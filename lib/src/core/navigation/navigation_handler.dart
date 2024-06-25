import 'package:flutter/material.dart';
import 'package:passaqui/src/modules/auth/create-account/create_account_screen.dart';
import 'package:passaqui/src/modules/auth/forgot_password/forgot_password_screen.dart';
import 'package:passaqui/src/modules/auth/forgot_password/success/forgot_password_success.dart';
import 'package:passaqui/src/modules/auth/login/login_screen.dart';
import 'package:passaqui/src/modules/auth/success/success_screen.dart';
import 'package:passaqui/src/modules/hire/confirmEmail/hire_confirm_email.dart';
import 'package:passaqui/src/modules/hire/cpf/hire_cpf_screen.dart';
import 'package:passaqui/src/modules/hire/installment/hire_installment_screen.dart';
import 'package:passaqui/src/modules/hire/steps/hire_step_screen.dart';
import 'package:passaqui/src/modules/hire/value/hire_value_screen.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/modules/welcome/welcome_screen.dart';
import 'package:passaqui/src/modules/withdraw/steps/withdraw_step_screen.dart';
import 'package:passaqui/src/modules/withdraw/welcome/withdraw_welcome_screen.dart';
import 'package:passaqui/src/modules/hire/confirmCpf/confirm_cpf_screen.dart';

import '../../modules/hire/wrongInfo/wrong_cpf_screen.dart';
import '../../modules/biometria/biometria_sucess/biometria_sucess_screen.dart';
import '../../modules/biometria/biometria_error/biometria_error_screen.dart';
import '../../modules/biometria/biometria_wait/biometria_wait_screen.dart';

class NavigationHandler {
  final GlobalKey<NavigatorState> _globalKey = GlobalKey();
  GlobalKey<NavigatorState> getGlobalKey() => _globalKey;

  Route<dynamic>? routes(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.route:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );
      case LoginScreen.route:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case SuccessScreen.route:
        return MaterialPageRoute(
          builder: (context) => SuccessScreen(),
        );
      case CreateAccountScreen.route:
        return MaterialPageRoute(
          builder: (context) => const CreateAccountScreen(),
        );
      case ForgotPasswordScreen.route:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case ForgotPasswordSuccessScreen.route:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordSuccessScreen(),
        );
      case WithdrawStepsScreen.route:
        return MaterialPageRoute(
          builder: (context) => const WithdrawStepsScreen(),
        );
      case WithdrawWelcomeScreen.route:
        return MaterialPageRoute(
          builder: (context) => const WithdrawWelcomeScreen(),
        );
      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case HireStepsScreen.route:
        return MaterialPageRoute(
          builder: (context) => const HireStepsScreen(),
        );
      case HireCpfScreen.route:
        return MaterialPageRoute(
          builder: (context) => const HireCpfScreen(),
        );
      case HireInstallmentScreen.route:
        final args = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          builder: (context) => HireInstallmentScreen(
            cpf: args?['cpf'],
          ),
        );
      case HireValueScreen.route:
        final args = settings.arguments as Map<String, dynamic>?;
        final String? cpf = args?['cpf'] as String?;
        return MaterialPageRoute(
          builder: (context) => HireValueScreen(
            jsonResponse: args?['jsonResponse'] as Map<String, dynamic>?,
            cpf : cpf ?? '',
          ),
        );
      case HireConfirmCpfScreen.route:
        final args = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          builder: (context) => HireConfirmCpfScreen(
            cpf: args?['cpf'],
          ),
        );
      case WrongPersonalInfoScreen.route:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(builder: (context) => WrongPersonalInfoScreen(
          isEmail: args?['isEmail'] ?? false,
        ));
      case HireConfirmEmailScreen.route:
        return MaterialPageRoute(
          builder: (context) => HireConfirmEmailScreen(
          ),
        );
    case BiometriaSucessScreen.route:
        return MaterialPageRoute(
          builder: (context) => BiometriaSucessScreen(
          ),
        );
    case BiometriaErrorScreen.route:
        return MaterialPageRoute(
          builder: (context) => BiometriaErrorScreen(
          ),
        );
    case BiometriaWaitScreen.route:
        return MaterialPageRoute(
          builder: (context) => BiometriaWaitScreen(
          ),
        );
    }
    return null;
  }

  Future<void> navigate(String path, {Object? arguments}) async {
    _globalKey.currentState?.pushNamed(path, arguments: arguments);
  }

  Future<void> pop() async {
    _globalKey.currentState?.pop();
  }
}
