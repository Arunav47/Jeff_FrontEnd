import 'package:flutter/material.dart';
import 'custom_themes/custom_themes.dart';

class TrendyTheme{
  TrendyTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.indigoAccent,
    scaffoldBackgroundColor: const Color(0xFFFFE4FA),
    textTheme: TrendyTextTheme.lightTextTheme,
    elevatedButtonTheme: TrendyElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: TrendyAppBarTheme.lightAppBarTheme,
    bottomNavigationBarTheme: TrendyBottomNavigationBarTheme.lightBottomNavigationBarTheme,
    bottomSheetTheme: TrendyBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: TrendyOutlinedButtonTheme.lightOutlinedButtonTheme,
    checkboxTheme: TrendyCheckboxTheme.lightCheckboxTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.indigoAccent,
    scaffoldBackgroundColor: const Color(0xFFFFE4FA),
    textTheme: TrendyTextTheme.lightTextTheme,
    elevatedButtonTheme: TrendyElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: TrendyAppBarTheme.lightAppBarTheme,
    bottomNavigationBarTheme: TrendyBottomNavigationBarTheme.lightBottomNavigationBarTheme,
    bottomSheetTheme: TrendyBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: TrendyOutlinedButtonTheme.lightOutlinedButtonTheme,
    checkboxTheme: TrendyCheckboxTheme.lightCheckboxTheme,
  );
}