import 'package:flutter/cupertino.dart';

class UpdateBankAccountController {
  ValueNotifier<bool> rememberPassword = ValueNotifier(false);

  void setRememberPassword(bool? rememberPass) {
    rememberPassword.value = rememberPass ?? false;
  }
}
