import 'package:flutter/widgets.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:xp_ui/src/styles/theme.dart';

class XpTab extends StatefulWidget {
  const XpTab(
      {super.key, required this.label, this.active = false, this.onPressed});
  final String label;
  final bool active;
  final VoidCallback? onPressed;

  @override
  State<XpTab> createState() => _XpTabState();

  XpTab copyWith({String? label, bool? active, VoidCallback? onPressed}) {
    return XpTab(
      label: label ?? this.label,
      active: active ?? this.active,
      onPressed: onPressed ?? this.onPressed,
    );
  }
}

class _XpTabState extends State<XpTab> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context);
    final border = BorderSide(
      color: theme.borderColor,
    );
    return MouseRegion(
      onEnter: (event) {
        setState(() => _hover = true);
      },
      onExit: (event) {
        setState(() => _hover = false);
      },
      child: GestureDetector(
        onTap: widget.onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: theme.controlsBackgroundColor,
              boxShadow: _hover || widget.active
                  ? [
                      BoxShadow(
                          inset: true,
                          color: theme.activeColor,
                          offset: const Offset(0, 3))
                    ]
                  : [],
              border: Border(
                top: border,
                left: border,
                right: border,
              )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 1, 12, 3),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
