import 'package:flutter/rendering.dart';
import 'package:xp_ui/src/styles/colors.dart';

class SidebarThemeData {
  final Color startColor;
  final Color endColor;

  SidebarThemeData(
      {this.startColor = XpDefaultThemeColors.sidebarStartColor,
      this.endColor = XpDefaultThemeColors.sidebarEndColor});
}
