import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xp_ui/xp_ui.dart';

class Textbox extends StatefulWidget {
  const Textbox(
      {super.key,
      this.controller,
      this.height,
      this.backgroundColor,
      this.multiline = false,
      this.maxLines = 1,
      this.obscureText = false,
      this.focusNode,
      this.onChanged,
      this.onSubmitted,
      this.inputFormatters,
      this.autofocus = false,
      this.labelWidget,
      this.labelText,
      this.labelPosition = TextboxLabelPosition.top});
  final TextEditingController? controller;
  final double? height;
  final Color? backgroundColor;
  final bool multiline;
  final int maxLines;
  final bool obscureText;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final Widget? labelWidget;
  final String? labelText;
  final TextboxLabelPosition labelPosition;

  @override
  State<Textbox> createState() => _TextboxState();
}

class _TextboxState extends State<Textbox> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();
  final GlobalKey _labelKey = GlobalKey();

  double labelWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => calcLabelWidth());
  }

  void calcLabelWidth() {
    if (widget.labelPosition == TextboxLabelPosition.top) return;
    final object = _labelKey.currentContext?.findRenderObject() as RenderBox?;
    if (object == null) return;
    labelWidth = object.size.width;
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant Textbox oldWidget) {
    if (oldWidget.labelText != widget.labelText ||
        oldWidget.labelWidget != widget.labelWidget) {
      calcLabelWidth();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context).textBoxStyle;
    final width = MediaQuery.sizeOf(context).width;
    return Flex(
      crossAxisAlignment: widget.labelPosition == TextboxLabelPosition.top
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      direction: widget.labelPosition == TextboxLabelPosition.top
          ? Axis.vertical
          : Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 4),
          key: _labelKey,
          child: DefaultTextStyle(
              style: theme.textStyle,
              child: widget.labelWidget ??
                  (widget.labelText != null
                      ? (Text(
                          widget.labelText!,
                        ))
                      : const SizedBox.shrink())),
        ),
        if ((widget.labelText != null || widget.labelWidget != null) &&
            (labelWidth > 0 || widget.labelPosition == TextboxLabelPosition.top))
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: widget.height ?? theme.height,
                minHeight: widget.height ?? theme.height,
                maxWidth: width - labelWidth),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: widget.backgroundColor ?? theme.backgroundColor,
                  border: Border.all(color: theme.borderColor)),
              child: EditableText(
                controller: widget.controller ?? _controller,
                focusNode: widget.focusNode ?? _node,
                style: theme.textStyle,
                cursorColor: theme.borderColor,
                backgroundCursorColor: theme.backgroundColor,
                obscureText: widget.obscureText,
                maxLines: widget.maxLines,
                inputFormatters: widget.inputFormatters,
                autofocus: widget.autofocus,
                onSubmitted: widget.onSubmitted,
                onChanged: widget.onChanged,
              ),
            ),
          )
      ],
    );
  }
}

enum TextboxLabelPosition {
  left,
  top;
}
