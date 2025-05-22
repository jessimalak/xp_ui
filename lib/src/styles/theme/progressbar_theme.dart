import 'dart:ui';

import 'package:xp_ui/src/styles/colors.dart';

class ProgressBarThemeData {
  final Color backgroundColor;
  final Color trackColor;
  final Color borderColor;

  const ProgressBarThemeData(
      {this.backgroundColor = XpColors.white,
      this.trackColor = XpColors.green,
      this.borderColor = XpDefaultThemeColors.outLineColor});
}