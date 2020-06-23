import 'package:flutter/material.dart';

import 'constants.dart';

class Themes {
  ThemeData getThemeWidget() {
    if (val == 0) {
      clr = Colors.white;
      anticlr = clr;

      return ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFF121212),
        bottomAppBarColor: Colors.black,
      );
    }
    else{
      clr = Colors.black;
      anticlr = clr;

      return ThemeData(
        primaryColor: Colors.grey[400],
        // scaffoldBackgroundColor: Colors.white,
      );
    }
  }
}
