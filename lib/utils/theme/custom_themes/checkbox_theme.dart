import 'package:flutter/material.dart';


class TrendyCheckboxTheme{
  TrendyCheckboxTheme._();
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    fillColor: WidgetStateProperty.all(Colors.indigo[200]),
    checkColor: WidgetStateProperty.all(Colors.white),
    side: const BorderSide(color: Colors.indigoAccent),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    fillColor: WidgetStateProperty.all(Colors.indigo[200]),
    checkColor: WidgetStateProperty.all(Colors.white),
    side: const BorderSide(color: Colors.indigoAccent),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );
}