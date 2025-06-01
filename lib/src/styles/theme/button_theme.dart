import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/colors.dart';

class ButtonThemeData {
  final Color borderColor;
  final BoxConstraints constraints;
  final Color hoverColorBottom;
  final Color hoverColorLeft;
  final Color hoverColorTop;
  final Color hoverColorRight;

  static const BoxConstraints _defaultButtonConstrains =
      BoxConstraints(minHeight: 23, minWidth: 75);
      
  static const Gradient normalBackground = LinearGradient(
      colors: [
        Color(0xFFFFFFFF),
        Color(0xFFecebe5),
        Color(0xFFd8d0c4),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0, .86, 1]);
  static const Gradient tapBackground = LinearGradient(
      colors: [
        Color(0xFFCDCAC3),
        Color(0xFFE3E3DB),
        Color(0xFFE5E5DE),
        Color(0xFFF2F2F1),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0, .8, .94, 1]);

  const ButtonThemeData(
      {this.borderColor = XpColors.darkBlue,
      this.constraints = _defaultButtonConstrains,
      this.hoverColorBottom = XpDefaultThemeColors.buttonHoverColorBottom,
      this.hoverColorLeft = XpDefaultThemeColors.buttonHoverColorLeft,
      this.hoverColorTop = XpDefaultThemeColors.buttonHoverColorTop,
      this.hoverColorRight = XpDefaultThemeColors.buttonHoverColorRight});

  static Color toPositionalHoverColor(Color color, Position position) {
    final HSLColor hsl = HSLColor.fromColor(color);
    switch (position) {
      case Position.left:
        return hsl.withSaturation(0.95).withLightness(.68).toColor();
      case Position.top:
        return hsl
            .withHue(hsl.hue + 1)
            .withSaturation(0.97)
            .withLightness(0.76)
            .toColor();
      case Position.right:
        return hsl
            .withHue(hsl.hue + 1)
            .withSaturation(0.98)
            .withLightness(0.85)
            .toColor();
      default:
    }
    return color;
  }
}

enum Position {
  bottom,
  left,
  top,
  right;
}
