import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/colors.dart';

class ButtonThemeData {
  final Color borderColor;
  final BoxConstraints constraints;
  final Color hoverColorBottom;
  final Color hoverColorLeft;
  final Color hoverColorTop;
  final Color hoverColorRight;

  static const BoxConstraints _defaultButtonConstrains = BoxConstraints(minHeight: 23, minWidth: 75);

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
        return hsl.withHue(hsl.hue + 1).withSaturation(0.97).withLightness(0.76).toColor();
      case Position.right:
        return hsl.withHue(hsl.hue + 1).withSaturation(0.98).withLightness(0.85).toColor();
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
