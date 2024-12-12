import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/colors.dart';

class ScrollbarTheme {
  final Color backgroundColor;
  final Color thumbColor;
  final double thickness;
  final Radius radius;
  late final Color shadowColor1;
  late final Color shadowColor2;

  ScrollbarTheme(
      {this.backgroundColor = XpColors.white,
      required this.thumbColor,
      this.thickness = 14,
      this.radius = const Radius.circular(3)}) {
    final HSLColor hslColor = HSLColor.fromColor(thumbColor);
    shadowColor1 = hslColor.withLightness(clampDouble(hslColor.lightness - 0.3, 0, 1)).toColor();
    shadowColor2 = hslColor.withLightness(clampDouble(hslColor.lightness - 0.2, 0, 1)).toColor();
  }
}
