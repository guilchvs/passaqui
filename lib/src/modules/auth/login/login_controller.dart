import 'package:flutter/cupertino.dart';

enum PageStatus {
  empty,
  loading
}

abstract class PassaquiBaseController {
  ValueNotifier<PageStatus> status = ValueNotifier(PageStatus.empty);

  void setStatus(PageStatus currentStatus){
    status.value = currentStatus;
  }
}

class LoginController extends PassaquiBaseController {

  ValueNotifier<bool> rememberPassword = ValueNotifier(false);

  void setRememberPassword(bool? rememberPass){
    rememberPassword.value = rememberPass ?? false;
  }


  Future<void> signIn({required String user, required String password}) async {
    try{
      setStatus(PageStatus.loading);
    }catch(err){}
    finally{
      setStatus(PageStatus.empty);
    }
  }
}