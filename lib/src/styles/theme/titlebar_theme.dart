import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/colors.dart';

class TitleBarThemeData {
  final Color backgroundColor;
  final Color foregroundColor;
  late final Color backgroundShade1;
  late final Color backgroundShade2;
  late final Color backgroundShade3;
  late final Color backgroundShade4;
  late final Color backgroundShade5;

  TitleBarThemeData({this.backgroundColor = XpColors.moonBlue, this.foregroundColor = XpColors.white}) {
    final HSLColor color = HSLColor.fromColor(backgroundColor);
    backgroundShade1 = color.withHue(color.hue - 11).withSaturation(color.saturation - 0.04).toColor();
    backgroundShade2 = color.withHue(color.hue + 3).withLightness(color.lightness - 0.07).toColor();
    backgroundShade3 = color.withHue(color.hue + 4).withLightness(color.lightness - 0.07).toColor();
    backgroundShade4 = color.withHue(color.hue - 4).toColor();
    backgroundShade5 = color.withHue(color.hue + 7).withLightness(color.lightness - 0.16).toColor();
  }
}