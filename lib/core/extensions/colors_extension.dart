import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';

extension CustomColorsExtensions on Map<ColorShades, Color> {
  Color? get c50 => this[ColorShades.c50];
  Color? get c100 => this[ColorShades.c100];
  Color? get c200 => this[ColorShades.c200];
  Color? get c300 => this[ColorShades.c300];
  Color? get c400 => this[ColorShades.c400];
  Color? get c500 => this[ColorShades.c500];
  Color? get c600 => this[ColorShades.c600];
  Color? get c700 => this[ColorShades.c700];
  Color? get c800 => this[ColorShades.c800];
}
