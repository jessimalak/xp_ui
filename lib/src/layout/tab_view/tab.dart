import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/theme.dart';

class XpTab extends StatelessWidget {
  const XpTab({super.key, required this.label, this.active = false});
  final String label;
  final bool active;
  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context);
    final border = BorderSide(color: theme.borderColor);
    return DecoratedBox(
      decoration:
          BoxDecoration(color: theme.controlsBackgroundColor, border: Border(top: border, left: border, right: border)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 1, 12, 3),
        child: Text(label),
      ),
    );
  }
}
