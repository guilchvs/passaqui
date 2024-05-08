import 'package:flutter/material.dart';

class AppTheme {

  static const Color _primaryColor = Color.fromRGBO(18, 96, 73, 1);
  static const Color _secondary = Color.fromRGBO(168, 202, 75, 1);
  static const Color _white = Color.fromRGBO(202, 208, 212, 1);
  static const Color _black = Color.fromRGBO(54, 51, 53, 1);
  static const Color grey = Color.fromRGBO(189, 190, 192, 1);
  static const Color _base = Color.fromRGBO(241, 241, 242, 1);

  static ThemeData appTheme = ThemeData(
    primaryColor: _primaryColor,
    highlightColor: grey,
    useMaterial3: false,
  );
}