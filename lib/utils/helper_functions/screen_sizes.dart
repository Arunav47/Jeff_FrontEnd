import 'package:flutter/material.dart';


class ScreenSizes {
  double screenWidth = 0;
  double screenHeight = 0;
  ScreenSizes._(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }
}