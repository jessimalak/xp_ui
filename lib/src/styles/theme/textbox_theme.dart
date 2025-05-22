import 'package:flutter/material.dart';
import 'package:xp_ui/src/styles/colors.dart';

class TextboxThemeData {
  final Color borderColor;
  final Color backgroundColor;
  final TextStyle textStyle;
  final double height;

  const TextboxThemeData(
      {this.backgroundColor = XpColors.white,
      this.borderColor = XpDefaultThemeColors.textBoxOutlineColor,
      this.height = 23,
      this.textStyle = const TextStyle()});
}