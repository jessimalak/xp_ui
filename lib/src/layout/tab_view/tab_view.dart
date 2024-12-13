import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/theme.dart';

class XpTabView extends StatelessWidget {
  const XpTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: DecoratedBox(
              decoration:
                  BoxDecoration(color: theme.controlsBackgroundColor, border: Border.all(color: theme.borderColor))),
        ),
        Positioned(child: Row(mainAxisSize: MainAxisSize.min,children: [],))
      ],
    );
  }
}
