import 'package:flutter/widgets.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:xp_ui/src/styles/theme/button_theme.dart';
import 'package:xp_ui/src/styles/theme/theme.dart';

class Button extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const Button({super.key, this.onPressed, required this.child});

  bool get enabled => onPressed != null;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _hover = false;
  bool _tap = false;

  static const Gradient _normalBackground = LinearGradient(
      colors: [
        Color(0xFFFFFFFF),
        Color(0xFFecebe5),
        Color(0xFFd8d0c4),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0, .86, 1]);
  static const Gradient _tapBackground = LinearGradient(
      colors: [
        Color(0xFFCDCAC3),
        Color(0xFFE3E3DB),
        Color(0xFFE5E5DE),
        Color(0xFFF2F2F1),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0, .8, .94, 1]);

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context);
    final buttonStyle = theme.buttonStyle ?? const ButtonThemeData();
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          boxShadow: _hover
              ? [
                  BoxShadow(
                      inset: true,
                      offset: const Offset(-1, 1),
                      color: buttonStyle.hoverColorTop),
                  BoxShadow(
                      inset: true,
                      offset: const Offset(1, 2),
                      color: buttonStyle.hoverColorRight),
                  BoxShadow(
                      inset: true,
                      offset: const Offset(-2, 2),
                      color: buttonStyle.hoverColorLeft),
                  BoxShadow(
                      inset: true,
                      offset: const Offset(2, -2),
                      color: buttonStyle.hoverColorBottom)
                ]
              : [],
          border: Border.all(
              color: buttonStyle.borderColor,
              strokeAlign: BorderSide.strokeAlignOutside,
              width: 0.5),
          gradient: _tap ? _tapBackground : _normalBackground),
      child: MouseRegion(
        onEnter: !widget.enabled
            ? null
            : (event) {
                setState(() => _hover = true);
              },
        onExit: (event) {
          setState(() => _hover = false);
        },
        child: GestureDetector(
          onTapDown: !widget.enabled
              ? null
              : (details) {
                  setState(() => _tap = true);
                },
          onTap: widget.onPressed,
          onTapUp: (details) {
            setState(() => _tap = false);
          },
          onLongPressDown: !widget.enabled
              ? null
              : (details) {
                  setState(() => _tap = true);
                },
          onLongPressUp: () {
            setState(() => _tap = false);
          },
          child: ConstrainedBox(
              constraints: buttonStyle.constraints,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DefaultTextStyle(
                    style: TextStyle(
                        color: !widget.enabled
                            ? theme.colorScheme.disabledColor
                            : theme.colorScheme.textColor),
                    child: widget.child),
              )),
        ),
      ),
    );
  }
}
