import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/colors.dart';
import 'package:xp_ui/src/styles/scrollbar_theme.dart';
import 'package:xp_ui/src/styles/theme/button_theme.dart';
import 'package:xp_ui/src/styles/theme/progressbar_theme.dart';
import 'package:xp_ui/src/styles/theme/textbox_theme.dart';
import 'package:xp_ui/src/styles/theme/titlebar_theme.dart';

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
  late final ButtonThemeData? buttonStyle;
  final ProgressBarThemeData progressBarTheme;
  final TitleBarThemeData titleBarTheme;
  final TextboxThemeData textBoxTheme;
  final ScrollbarTheme scrollbarTheme;

  XpThemeData(
      {this.accentColor = XpColors.moonBlue,
      this.activeColor = XpColors.orange,
      this.backgroundColor = XpColors.windowBackground,
      this.controlsBackgroundColor = XpColors.white,
      ButtonThemeData? buttonStyle,
      this.progressBarTheme = const ProgressBarThemeData(),
      this.textColor = XpDefaultThemeColors.textColor,
      this.borderColor = XpDefaultThemeColors.outLineColor,
      TextboxThemeData? textBoxTheme,
      TitleBarThemeData? titleBarTheme,
      ScrollbarTheme? scrollbarTheme})
      : titleBarTheme = titleBarTheme ?? TitleBarThemeData(backgroundColor: accentColor),
        textBoxTheme = textBoxTheme ?? TextboxThemeData(textStyle: TextStyle(color: textColor)),
        scrollbarTheme = scrollbarTheme ?? ScrollbarTheme(thumbColor: XpDefaultThemeColors.scrollbarThumbColor) {
    final HSLColor hslColor = HSLColor.fromColor(accentColor);
    lightAccentColor = hslColor.withLightness(0.9).toColor();
    if (buttonStyle == null) {
      this.buttonStyle = ButtonThemeData(
          hoverColorBottom: activeColor,
          hoverColorLeft: ButtonThemeData.toPositionalHoverColor(activeColor, Position.left),
          hoverColorTop: ButtonThemeData.toPositionalHoverColor(activeColor, Position.top),
          hoverColorRight: ButtonThemeData.toPositionalHoverColor(activeColor, Position.right));
    }
  }
}
