import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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
  final ButtonStyle buttonStyle;

  static const Color _accentMoon = Color.fromARGB(255, 10, 133, 216);
  static const Color _activeDefault = Color.fromARGB(255, 238, 196, 58);
  static const Color _lightBackgroundDefault = Color.fromARGB(255, 248, 248, 248);

  XpThemeData(
      {this.accentColor = _accentMoon,
      this.activeColor = _activeDefault,
      this.backgroundColor = _lightBackgroundDefault,
      this.buttonStyle = const ButtonStyle()}) {
    final HSLColor hslColor = HSLColor.fromColor(accentColor);
    lightAccentColor = hslColor.withLightness(0.9).toColor();
  }
}

class ButtonStyle {
  final Color borderColor;
  final BoxConstraints constraints;

  static const Color _defaultMoonColor = Color(0xff003c74);
  static const BoxConstraints _defaultButtonConstrains = BoxConstraints(minHeight: 23, minWidth: 75);

  const ButtonStyle({this.borderColor = _defaultMoonColor, this.constraints = _defaultButtonConstrains});
}
