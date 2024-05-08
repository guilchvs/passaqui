import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:passaqui/src/app.dart';
import 'package:passaqui/src/core/di/service_locator.dart';

void main() {

  runZonedGuarded(() async {

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    DIService().init();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(const PassaquiApp());

  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}

