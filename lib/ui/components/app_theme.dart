import 'package:flutter/material.dart';

class AppTheme {
  static Color primarySwatch = Colors.green;
  static Color primaryColor = Color(0xFF388E3C);
  static Color primaryColorLight = Color(0xFF66BB6A);
  static Color primaryColorDark = Color(0xFF1F7925);
  static Color backgroundColor = Color(0xFFDAEEDA);
  static Color backgroundColorLight = Color(0xFFFFFFFF);
  static Color dividerColor = Color(0x2CF3FFF3);
  static Color textColor = Color(0xFF1F7925);
  static Color textColorDark = Color(0xFF152715);
  static Color textColorLight = Color(0xFF3F643F);
  static Color disabledColorLight = Color(0xFFF3F3F3);
  static Color disabledColor = Color(0xFFC3C5C3);
  static Color disabledColorDark = Color(0xFF7C7C7C);
  static Color secondaryColor = Color(0xFF388E8A);
  static Color secondaryColorLight = Color(0xFF66BB97);
  static Color secondaryColorDark = Color(0xFF1F7954);
  static Color successColor = Color(0xFF47AD55);
  static Color errorColor = Color(0xFFC04848);
  static Color warningColor = Color(0xFFAD9A47);
  static Color brightColor = Color(0xFFF1F1F1);
  static Color goldColor = Color.fromARGB(255, 255, 235, 57);
  static Color greyColor = Color(0xFF3A5160);
  static Color greyColorLight = Color(0xFF313A44);
  static Color greyColorDark = Color(0xFFECEFF1);
  static ThemeData get light => ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Cabin',
      primarySwatch: Colors.green,
      primaryColor: primaryColor,
      primaryColorLight: primaryColorLight,
      primaryColorDark: primaryColorDark,
      backgroundColor: backgroundColor);
  static ThemeData get dark => ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Cabin',
      primarySwatch: Colors.green,
      primaryColor: primaryColor,
      primaryColorLight: primaryColorLight,
      primaryColorDark: primaryColorDark,
      backgroundColor: backgroundColor);
}
