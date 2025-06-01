import 'package:flutter/rendering.dart';
import 'package:xp_ui/src/styles/colors.dart';

class ColorScheme {
  final Color primaryColor;
  late final Color lightPrimaryColor;
  final Color accentColor;
  final Color activeColor;
  final Color backgroundColor;
  final Color controlsBackgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color borderControlColor;
  final Color disabledColor;

  ColorScheme({
    this.primaryColor = XpColors.moonBlue,
    this.activeColor = XpColors.orange,
    this.accentColor = XpColors.green,
    this.backgroundColor = XpDefaultThemeColors.windowBackground,
    this.controlsBackgroundColor = XpColors.white,
    this.textColor = XpDefaultThemeColors.textColor,
    this.borderColor = XpDefaultThemeColors.outlineColor,
    this.borderControlColor = XpDefaultThemeColors.controlsOutlineColor,
    this.disabledColor = XpDefaultThemeColors.disabledTextColor
  }) {
    final HSLColor hslColor = HSLColor.fromColor(primaryColor);
    lightPrimaryColor = hslColor.withLightness(0.9).toColor();
  }
}
