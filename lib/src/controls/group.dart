import 'package:flutter/material.dart';
import 'package:xp_ui/src/styles/colors.dart';
import 'package:xp_ui/src/styles/theme/theme.dart';

class Group extends StatelessWidget {
  final Widget label;
  final List<Widget> children;
  final double spacing;
  const Group(
      {super.key,
      required this.label,
      required this.children,
      this.spacing = 8.0});

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context);
    final labelWidget = DefaultTextStyle(
        style: TextStyle(
            color: theme.groupTheme.labelColor ??
                XpDefaultThemeColors.expandableTextColor,
            fontSize: 12),
        child: label);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border:
                Border.all(color: theme.colorScheme.borderColor.withAlpha(128)),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: labelWidget,
                    ),
                  ),
                  ...children
                      .expand((button) sync* {
                        yield const SizedBox(
                          width: 8,
                          height: 8,
                        );
                        yield button;
                      })
                      .skip(1)
                     
                ],
              ),
            ),
            Positioned(
              left: 8,
              top: -10,
              child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: theme.colorScheme.backgroundColor),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: labelWidget,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
