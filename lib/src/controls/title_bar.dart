import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:xp_ui/src/styles/colors.dart';
import 'package:xp_ui/xp_ui.dart';

class TitleBar extends StatelessWidget {
  final String title;
  final bool showCloseButton;
  final bool showMaximizeButton;
  final bool showMinimizeButton;
  final bool showHelpButton;
  final VoidCallback? onHelpButtonPressed;
  const TitleBar(this.title,
      {super.key,
      this.showCloseButton = true,
      this.showMaximizeButton = true,
      this.showMinimizeButton = true,
      this.showHelpButton = false,
      this.onHelpButtonPressed});

  @override
  Widget build(BuildContext context) {
    final style = XpTheme.of(context).titleBarStyle;
    final HSLColor color = HSLColor.fromColor(style.backgroundColor);
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 0.5,
                  color: color
                      .withHue(color.hue + 13)
                      .withSaturation(color.saturation - 0.04)
                      .withLightness(color.lightness - 0.15)
                      .toColor())),
          gradient: LinearGradient(
              colors: [
                style.backgroundShade1,
                style.backgroundShade2,
                style.backgroundShade3,
                style.backgroundColor,
                style.backgroundColor,
                style.backgroundShade4,
                style.backgroundShade5,
                style.backgroundShade5
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.03, .08, .40, .88, .93, .95, .96, 1])),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 3, 5, 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: Platform.isMacOS ? 72 : 3,
                ),
                Text(
                  title,
                  style: const TextStyle(color: XpColors.white, fontSize: 13),
                ),
              ],
            ),
            Row(
              children: [
                if (showHelpButton)
                  TitleBarActionButton(
                    icon: ActionButtonIcon.help,
                    onPressed: onHelpButtonPressed,
                  ),
                if (showMinimizeButton)
                  TitleBarActionButton(
                    icon: ActionButtonIcon.minimize,
                    onPressed: () {},
                  ),
                if (showMaximizeButton)
                  TitleBarActionButton(
                    icon: ActionButtonIcon.maximize,
                    onPressed: () {},
                  ),
                if (showCloseButton)
                  XpCloseButton(
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _TitleBarButtonHover extends StatefulWidget {
  final Widget child;

  const _TitleBarButtonHover({super.key, required this.child});
  @override
  State<_TitleBarButtonHover> createState() => _TitleBarButtonHoverState();
}

class _TitleBarButtonHoverState extends State<_TitleBarButtonHover> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (event) {
          setState(() => _hover = true);
        },
        onExit: (event) {
          setState(() => _hover = false);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: _hover
                  ? const RadialGradient(
                      colors: [Color(0x6AFFFFFF), XpColors.transparent])
                  : null),
          child: widget.child,
        ));
  }
}

class XpCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const XpCloseButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final TitleBarStyle titleBarStyle = XpTheme.of(context).titleBarStyle;
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: GestureDetector(
        onTap: onPressed ??
            () {
              Navigator.pop(context);
            },
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: titleBarStyle.foregroundColor),
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              boxShadow: const [
                BoxShadow(
                    inset: true,
                    offset: Offset(-1, 1),
                    color: XpColors.lightRed,
                    blurRadius: 1),
                BoxShadow(
                    inset: true,
                    offset: Offset(1, 2),
                    color: XpColors.lightRed,
                    blurRadius: 1),
                BoxShadow(
                    inset: true,
                    offset: Offset(-2, 2),
                    color: XpColors.red,
                    blurRadius: 1),
                BoxShadow(
                    inset: true,
                    offset: Offset(2, -2),
                    color: XpColors.red,
                    blurRadius: 1)
              ],
              gradient: const LinearGradient(
                  colors: [XpColors.lightRed, XpColors.red],
                  begin: Alignment.topLeft)),
          child: _TitleBarButtonHover(
            child: Image.asset(
              ActionButtonIcon.close.assetPath,
              package: 'xp_ui',
            ),
          ),
        ),
      ),
    );
  }
}

class TitleBarActionButton extends StatelessWidget {
  final ActionButtonIcon icon;
  final VoidCallback? onPressed;
  const TitleBarActionButton({super.key, this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    final TitleBarStyle titleBarStyle = XpTheme.of(context).titleBarStyle;
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: GestureDetector(
        onTap: onPressed ??
            () {
              Navigator.pop(context);
            },
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: titleBarStyle.foregroundColor),
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              boxShadow: [
                BoxShadow(
                    inset: true,
                    offset: const Offset(-1, 1),
                    color: titleBarStyle.backgroundShade2,
                    blurRadius: 1),
                BoxShadow(
                    inset: true,
                    offset: const Offset(1, 2),
                    color: titleBarStyle.backgroundShade2,
                    blurRadius: 1),
                BoxShadow(
                    inset: true,
                    offset: const Offset(-2, 2),
                    color: titleBarStyle.backgroundColor,
                    blurRadius: 1),
                BoxShadow(
                    inset: true,
                    offset: const Offset(2, -2),
                    color: titleBarStyle.backgroundColor,
                    blurRadius: 1)
              ],
              gradient: LinearGradient(colors: [
                titleBarStyle.backgroundShade1,
                titleBarStyle.backgroundShade3
              ], begin: Alignment.topLeft)),
          child: _TitleBarButtonHover(
            child: Image.asset(
              icon.assetPath,
              package: 'xp_ui',
            ),
          ),
        ),
      ),
    );
  }
}

enum ActionButtonIcon {
  close('close_icon'),
  maximize('maximize_icon'),
  maximized('maximized_icon'),
  minimize('minimize_icon'),
  help('help_icon');

  const ActionButtonIcon(this._name);
  final String _name;
  String get assetPath => 'assets/action_icons/$_name.png';
}
