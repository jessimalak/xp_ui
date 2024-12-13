import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/colors.dart';
import 'package:xp_ui/src/styles/scrollbar_theme.dart';

class XpTheme extends StatelessWidget {
  const XpTheme({super.key, required this.data, required this.child});
  final XpThemeData data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _InheritedXpTheme(theme: this, child: child);
  }

  static XpThemeData of(BuildContext context) {
    final _InheritedXpTheme? inheritedXpTheme = context.dependOnInheritedWidgetOfExactType<_InheritedXpTheme>();
    return inheritedXpTheme?.theme.data ?? XpThemeData();
  }
}

class _InheritedXpTheme extends InheritedWidget {
  final XpTheme theme;

  const _InheritedXpTheme({required this.theme, required super.child});
  @override
  bool updateShouldNotify(covariant _InheritedXpTheme old) => theme.data != old.theme.data;
}

class XpThemeData with Diagnosticable {
  final Color accentColor;
  late final Color lightAccentColor;
  final Color activeColor;
  final Color backgroundColor;
  final Color controlsBackgroundColor;
  final Color textColor;
  final Color borderColor;
  late final ButtonStyle? buttonStyle;
  final ProgressBarStyle progressBarStyle;
  final TitleBarStyle titleBarStyle;
  final TextboxStyle textBoxStyle;
  final ScrollbarTheme scrollbarTheme;

  XpThemeData(
      {this.accentColor = XpColors.moonBlue,
      this.activeColor = XpColors.orange,
      this.backgroundColor = XpColors.windowBackground,
      this.controlsBackgroundColor = XpColors.white,
      ButtonStyle? buttonStyle,
      this.progressBarStyle = const ProgressBarStyle(),
      this.textColor = XpDefaultThemeColors.textColor,
      this.borderColor = XpDefaultThemeColors.outLineColor,
      TextboxStyle? textBoxStyle,
      TitleBarStyle? titleBarStyle,
      ScrollbarTheme? scrollbarTheme})
      : titleBarStyle = titleBarStyle ?? TitleBarStyle(backgroundColor: accentColor),
        textBoxStyle = textBoxStyle ?? TextboxStyle(textStyle: TextStyle(color: textColor)),
        scrollbarTheme = scrollbarTheme ?? ScrollbarTheme(thumbColor: XpDefaultThemeColors.scrollbarThumbColor) {
    final HSLColor hslColor = HSLColor.fromColor(accentColor);
    lightAccentColor = hslColor.withLightness(0.9).toColor();
    if (buttonStyle == null) {
      this.buttonStyle = ButtonStyle(
          hoverColorBottom: activeColor,
          hoverColorLeft: ButtonStyle.toPositionalHoverColor(activeColor, Position.left),
          hoverColorTop: ButtonStyle.toPositionalHoverColor(activeColor, Position.top),
          hoverColorRight: ButtonStyle.toPositionalHoverColor(activeColor, Position.right));
    }
  }
}

class ButtonStyle {
  final Color borderColor;
  final BoxConstraints constraints;
  final Color hoverColorBottom;
  final Color hoverColorLeft;
  final Color hoverColorTop;
  final Color hoverColorRight;

  static const BoxConstraints _defaultButtonConstrains = BoxConstraints(minHeight: 23, minWidth: 75);

  const ButtonStyle(
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

class ProgressBarStyle {
  final Color backgroundColor;
  final Color trackColor;
  final Color borderColor;

  const ProgressBarStyle(
      {this.backgroundColor = XpColors.white,
      this.trackColor = XpColors.green,
      this.borderColor = XpDefaultThemeColors.outLineColor});
}

class TitleBarStyle {
  final Color backgroundColor;
  final Color foregroundColor;
  late final Color backgroundShade1;
  late final Color backgroundShade2;
  late final Color backgroundShade3;
  late final Color backgroundShade4;
  late final Color backgroundShade5;

  TitleBarStyle({this.backgroundColor = XpColors.moonBlue, this.foregroundColor = XpColors.white}) {
    final HSLColor color = HSLColor.fromColor(backgroundColor);
    backgroundShade1 = color.withHue(color.hue - 11).withSaturation(color.saturation - 0.04).toColor();
    backgroundShade2 = color.withHue(color.hue + 3).withLightness(color.lightness - 0.07).toColor();
    backgroundShade3 = color.withHue(color.hue + 4).withLightness(color.lightness - 0.07).toColor();
    backgroundShade4 = color.withHue(color.hue - 4).toColor();
    backgroundShade5 = color.withHue(color.hue + 7).withLightness(color.lightness - 0.16).toColor();
  }
}

class TextboxStyle {
  final Color borderColor;
  final Color backgroundColor;
  final TextStyle textStyle;
  final double height;

  const TextboxStyle(
      {this.backgroundColor = XpColors.white,
      this.borderColor = XpDefaultThemeColors.textBoxOutlineColor,
      this.height = 23,
      this.textStyle = const TextStyle()});
}
