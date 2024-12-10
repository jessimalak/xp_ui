import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/controls/styles/theme.dart';

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const Button({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          border: Border.all(color: theme.buttonStyle.borderColor),
          gradient: const LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFecebe5),
                Color(0xFFd8d0c4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 86, 100])),
      child: ConstrainedBox(constraints: theme.buttonStyle.constraints, child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: child,
      )),
    );
  }
}
