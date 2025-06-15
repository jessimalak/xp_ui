import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:xp_ui/src/styles/colors.dart';

const double kDefaultStatusBarHeight = 24;

class StatusBar extends StatelessWidget {
  final Widget child;
  final List<Widget> rightChildren;
  const StatusBar(
      {super.key, required this.child, this.rightChildren = const []});

  @override
  Widget build(BuildContext context) {
    const divider = VerticalDivider(
      color: XpDefaultThemeColors.statusbarDividerColor,
      indent: 4,
      endIndent: 4,
    );
    return DecoratedBox(
      decoration: const BoxDecoration(
          color: XpDefaultThemeColors.windowBackground,
          boxShadow: [
            BoxShadow(
                inset: true,
                offset: Offset(0, 1),
                blurRadius: 2,
                color: XpColors.grey)
          ]),
      child: SizedBox(
          height: kDefaultStatusBarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                child,
                Row(
                  children: [
                    if (rightChildren.isNotEmpty) divider,
                    ...rightChildren.expand((button) sync* {
                      yield divider;
                      yield button;
                    }).skip(1)
                  ],
                )
              ],
            ),
          )),
    );
  }
}
