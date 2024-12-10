import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/colors.dart';

class XpTheme extends StatelessWidget {
  const XpTheme({super.key, required this.data, required this.child});
  final XpThemeData data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _InheritedXpTheme(theme: this, child: child);
  }

  static XpThemeData of(BuildContext context) {
    final _InheritedXpTheme? inheritedXpTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedXpTheme>();
    return inheritedXpTheme?.theme.data ?? XpThemeData();
  }
}

class _InheritedXpTheme extends InheritedWidget {
  final XpTheme theme;

  const _InheritedXpTheme({required this.theme, required super.child});
  @override
  bool updateShouldNotify(covariant _InheritedXpTheme old) =>
      theme.data != old.theme.data;
}

class XpThemeData with Diagnosticable {
  final Color accentColor;
  late final Color lightAccentColor;
  final Color activeColor;
  final Color backgroundColor;
  final Color textColor;
  late final ButtonStyle? buttonStyle;
  final ProgressBarStyle progressBarStyle;

  static const Color _lightBackgroundDefault = Color(0xFFF8F8F8);

  XpThemeData(
      {this.accentColor = XpColors.moonBlue,
      this.activeColor = XpColors.orange,
      this.backgroundColor = _lightBackgroundDefault,
      ButtonStyle? buttonStyle,
      this.progressBarStyle = const ProgressBarStyle(),
      this.textColor = XpDefaultThemeColors.textColor}) {
    print('theme Data');
    final HSLColor hslColor = HSLColor.fromColor(accentColor);
    lightAccentColor = hslColor.withLightness(0.9).toColor();
    if (buttonStyle == null) {
      this.buttonStyle = ButtonStyle(
          hoverColorBottom: activeColor,
          hoverColorLeft:
              ButtonStyle.toPositionalHoverColor(activeColor, Position.left),
          hoverColorTop:
              ButtonStyle.toPositionalHoverColor(activeColor, Position.top),
          hoverColorRight:
              ButtonStyle.toPositionalHoverColor(activeColor, Position.right));
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

  static const BoxConstraints _defaultButtonConstrains =
      BoxConstraints(minHeight: 23, minWidth: 75);

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

class ProgressBarStyle {
  final Color backgroundColor;
  final Color trackColor;
  final Color borderColor;

  const ProgressBarStyle(
      {this.backgroundColor = XpColors.white,
      this.trackColor = XpColors.green,
      this.borderColor = XpDefaultThemeColors.outLineColor});
}
