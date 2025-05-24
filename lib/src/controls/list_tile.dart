import 'package:flutter/material.dart' hide ListTile;
import 'package:xp_ui/src/styles/colors.dart';

class ListTile extends StatefulWidget {
  final Widget label;
  final Widget icon;
  final double iconSize;
  final VoidCallback? onPressed;
  const ListTile(
      {super.key, required this.label, required this.icon, this.iconSize = 24, this.onPressed});

  @override
  State<ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<ListTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _hover = true),
      onExit: (event) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: widget.iconSize,
                  width: widget.iconSize,
                  child: FittedBox(
                    child: widget.icon,
                  )),
              DefaultTextStyle(
                  style: TextStyle(
                      color: XpDefaultThemeColors.expandableTextColor,
                      decoration: _hover ? TextDecoration.underline : null),
                  child: widget.label),
            ],
          ),
        ),
      ),
    );
  }
}
