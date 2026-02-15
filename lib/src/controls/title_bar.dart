import 'package:flutter/widgets.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:xp_ui/src/styles/colors.dart';
import 'package:xp_ui/src/styles/theme/titlebar_theme.dart';
import 'package:xp_ui/xp_ui.dart';

class TitleBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> trailing;
  final List<Widget> leading;

  const TitleBar(this.title, {super.key, this.trailing = const [], this.leading = const []});

  @override
  State<TitleBar> createState() => _TitleBarState();

  @override
  Size get preferredSize => const Size.fromHeight(32);
}

class _TitleBarState extends State<TitleBar> {
  @override
  Widget build(BuildContext context) {
    final style = XpTheme.of(context).titleBarTheme;
    final HSLColor color = HSLColor.fromColor(style.backgroundColor);
    final Widget titleWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 6,
        ),
        Text(
          widget.title,
          style: TextStyle(
              color: style.foregroundColor, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Trebuchet'),
        ),
      ],
    );
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
        padding: const EdgeInsets.fromLTRB(4, 4, 6, 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [...widget.leading, titleWidget],
            ),
            if (widget.trailing.isNotEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: widget.trailing,
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
              gradient: _hover ? const RadialGradient(colors: [Color(0x6AFFFFFF), XpColors.transparent]) : null),
          child: widget.child,
        ));
  }
}

class XpCloseButton extends StatefulWidget {
  final VoidCallback? onPressed;
  const XpCloseButton({super.key, this.onPressed});

  @override
  State<XpCloseButton> createState() => _XpCloseButtonState();
}

class _XpCloseButtonState extends State<XpCloseButton> {
  bool _tap = false;
  @override
  Widget build(BuildContext context) {
    final TitleBarThemeData titleBarStyle = XpTheme.of(context).titleBarTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: GestureDetector(
        onTap: widget.onPressed ??
            () {
              Navigator.pop(context);
            },
        onTapDown: (details) {
          setState(() => _tap = true);
        },
        onTapUp: (details) {
          setState(() => _tap = false);
        },
        onLongPressDown: (details) {
          setState(() => _tap = true);
        },
        onLongPressUp: () {
          setState(() => _tap = false);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: titleBarStyle.foregroundColor),
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              boxShadow: [
                BoxShadow(
                    inset: true,
                    offset: const Offset(-1, 1),
                    color: _tap ? XpColors.darkRed : XpColors.lightRed,
                    blurRadius: 1),
                BoxShadow(
                    inset: true,
                    offset: const Offset(1, 2),
                    color: _tap ? XpColors.darkRed : XpColors.lightRed,
                    blurRadius: 1),
                const BoxShadow(inset: true, offset: Offset(-2, 2), color: XpColors.red, blurRadius: 1),
                const BoxShadow(inset: true, offset: Offset(2, -2), color: XpColors.red, blurRadius: 1)
              ],
              gradient: _tap
                  ? const LinearGradient(colors: [XpColors.red, XpColors.darkRed])
                  : const LinearGradient(colors: [XpColors.lightRed, XpColors.red], begin: Alignment.topLeft)),
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

class TitleBarActionButton extends StatefulWidget {
  final ActionButtonIcon icon;
  final VoidCallback? onPressed;
  const TitleBarActionButton({super.key, this.onPressed, required this.icon});

  @override
  State<TitleBarActionButton> createState() => _TitleBarActionButtonState();
}

class _TitleBarActionButtonState extends State<TitleBarActionButton> {
  bool _tap = false;

  @override
  Widget build(BuildContext context) {
    final TitleBarThemeData titleBarStyle = XpTheme.of(context).titleBarTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (details) {
          setState(() => _tap = true);
        },
        onTapUp: (details) {
          setState(() => _tap = false);
        },
        onLongPressDown: (details) {
          setState(() => _tap = true);
        },
        onLongPressUp: () {
          setState(() => _tap = false);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: titleBarStyle.foregroundColor),
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              boxShadow: [
                BoxShadow(
                    inset: true,
                    offset: const Offset(-1, 1),
                    color: _tap ? titleBarStyle.backgroundShade5 : titleBarStyle.backgroundShade2,
                    blurRadius: 1),
                BoxShadow(
                    inset: true,
                    offset: const Offset(1, 2),
                    color: _tap ? titleBarStyle.backgroundShade5 : titleBarStyle.backgroundShade2,
                    blurRadius: 1),
                BoxShadow(
                    inset: true,
                    offset: const Offset(-2, 2),
                    color: _tap ? titleBarStyle.backgroundShade3 : titleBarStyle.backgroundColor,
                    blurRadius: 1),
                BoxShadow(inset: true, offset: const Offset(2, -2), color: titleBarStyle.backgroundColor, blurRadius: 1)
              ],
              gradient: _tap
                  ? LinearGradient(colors: [titleBarStyle.backgroundShade3, titleBarStyle.backgroundShade5])
                  : LinearGradient(
                      colors: [titleBarStyle.backgroundShade1, titleBarStyle.backgroundShade3],
                      begin: Alignment.topLeft)),
          child: _TitleBarButtonHover(
            child: Image.asset(
              widget.icon.assetPath,
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
