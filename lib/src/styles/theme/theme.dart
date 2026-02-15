import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/colors.dart';
import 'package:xp_ui/src/styles/scrollbar_theme.dart';
import 'package:xp_ui/src/styles/theme/button_theme.dart';
import 'package:xp_ui/src/styles/theme/checkbox_theme.dart';
import 'package:xp_ui/src/styles/theme/color_scheme.dart';
import 'package:xp_ui/src/styles/theme/expandable_item_theme.dart';
import 'package:xp_ui/src/styles/theme/group_theme.dart';
import 'package:xp_ui/src/styles/theme/progressbar_theme.dart';
import 'package:xp_ui/src/styles/theme/sidebar_theme.dart';
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
  final ColorScheme colorScheme;
  late final ButtonThemeData? buttonStyle;
  final ProgressBarThemeData progressBarTheme;
  late final TitleBarThemeData titleBarTheme;
  late final TextboxThemeData textBoxTheme;
  final ScrollbarTheme scrollbarTheme;
  final SidebarThemeData sidebarTheme;
  final ExpandableItemThemeData expandableItemTheme;
  late final CheckboxThemeData checkboxTheme;
  final Duration fastAnimationDuration;
  final Curve animationCurve;
  final GroupThemeData groupTheme;

  XpThemeData(
      {ColorScheme? colorScheme,
      ButtonThemeData? buttonStyle,
      this.progressBarTheme = const ProgressBarThemeData(),
      TextboxThemeData? textBoxTheme,
      TitleBarThemeData? titleBarTheme,
      ScrollbarTheme? scrollbarTheme,
      SidebarThemeData? sidebarTheme,
      this.checkboxTheme = const CheckboxThemeData(),
      this.fastAnimationDuration = const Duration(milliseconds: 300),
      this.animationCurve = Curves.linear,
      ExpandableItemThemeData? expandableItemTheme,
      this.groupTheme = const GroupThemeData()})
      : colorScheme = colorScheme ?? ColorScheme(),
        scrollbarTheme = scrollbarTheme ??
            ScrollbarTheme(
                thumbColor: XpDefaultThemeColors.scrollbarThumbColor),
        sidebarTheme = sidebarTheme ?? SidebarThemeData(),
        expandableItemTheme = expandableItemTheme ?? ExpandableItemThemeData() {
    this.titleBarTheme = titleBarTheme ??
        TitleBarThemeData(backgroundColor: this.colorScheme.primaryColor);
    this.textBoxTheme = textBoxTheme ??
        TextboxThemeData(
            textStyle: TextStyle(color: this.colorScheme.textColor));
    if (buttonStyle == null) {
      this.buttonStyle = ButtonThemeData(
          hoverColorBottom: this.colorScheme.activeColor,
          hoverColorLeft: ButtonThemeData.toPositionalHoverColor(
              this.colorScheme.activeColor, Position.left),
          hoverColorTop: ButtonThemeData.toPositionalHoverColor(
              this.colorScheme.activeColor, Position.top),
          hoverColorRight: ButtonThemeData.toPositionalHoverColor(
              this.colorScheme.activeColor, Position.right));
    }
  }
}
