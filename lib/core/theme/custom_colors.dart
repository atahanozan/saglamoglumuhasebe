import 'dart:ui';

enum ColorShades { c50, c100, c200, c300, c400, c500, c600, c700, c800 }

class CustomThemeColors {
  static const Map<ColorShades, Color> customBlack = {
    ColorShades.c50: Color(0xffd3d3d3),
    ColorShades.c100: Color(0xffbcbcbc),
    ColorShades.c200: Color(0xffa6a6a6),
    ColorShades.c300: Color(0xff909090),
    ColorShades.c400: Color(0xff7a7a7a),
    ColorShades.c500: Color(0xff646464),
    ColorShades.c600: Color(0xff4d4d4d),
    ColorShades.c700: Color(0xff373737),
    ColorShades.c800: Color(0xff212121),
  };
  static const Map<ColorShades, Color> customYellow = {
    ColorShades.c50: Color(0xfffff3cc),
    ColorShades.c100: Color(0xffffedb3),
    ColorShades.c200: Color(0xffffe799),
    ColorShades.c300: Color(0xffffe280),
    ColorShades.c400: Color(0xffffdc66),
    ColorShades.c500: Color(0xffffd64d),
    ColorShades.c600: Color(0xffffd033),
    ColorShades.c700: Color(0xffffca1a),
    ColorShades.c800: Color(0xffffc400),
  };
  static const Color customWhite = Color(0xffFAFAFA);
}
