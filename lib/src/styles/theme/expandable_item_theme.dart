import 'dart:ui';

import 'package:xp_ui/src/styles/colors.dart';

class ExpandableItemThemeData {
  final Color contentBackgroundColor;
  final Color titleStartBackgroundColor;
  final Color titleEndBackgroundColor;
  final Color textColor;

  ExpandableItemThemeData(
      {this.contentBackgroundColor =
          XpDefaultThemeColors.expandableContentBackgroundColor,
      this.textColor = XpDefaultThemeColors.expandableTextColor,
      this.titleStartBackgroundColor = XpColors.white,
      this.titleEndBackgroundColor =
          XpDefaultThemeColors.expandableTitleEndColor});
}
