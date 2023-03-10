//The following variables will be Global throughout the whole program


//---------------------------------------------
//                  THEME
//---------------------------------------------

//Colors:

import 'package:flutter/material.dart';

class ThemeColors {
  MaterialColor primary = MaterialColor(const Color.fromRGBO(27, 116, 204, 1).value, const <int, Color>{
      50: Color.fromRGBO(27, 116, 204, 0.1),
      100: Color.fromRGBO(27, 116, 204, 0.2),
      200: Color.fromRGBO(27, 116, 204, 0.3),
      300: Color.fromRGBO(27, 116, 204, 0.4),
      400: Color.fromRGBO(27, 116, 204, 0.5),
      500: Color.fromRGBO(27, 116, 204, 0.6),
      600: Color.fromRGBO(27, 116, 204, 0.7),
      700: Color.fromRGBO(27, 116, 204, 0.8),
      800: Color.fromRGBO(27, 116, 204, 0.9),
      900: Color.fromRGBO(27, 116, 204, 1),
    },
  );

  Color secondary = const Color.fromRGBO(111, 233, 17, 1);
}

