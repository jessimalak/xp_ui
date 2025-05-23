import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:xp_ui/src/styles/theme/theme.dart';
import 'package:xp_ui/src/utils/widget_surveyor.dart';

const double _kDefaultCheckboxSize = 12;
const double _kDefaultSpacing = 4;

class XpCheckbox extends StatefulWidget {
  final bool value;
  final String label;
  final void Function(bool value)? onChanged;
  const XpCheckbox(
      {super.key, required this.value, this.onChanged, required this.label});

  @override
  State<XpCheckbox> createState() => _XpCheckboxState();

  static Widget defaultItemBuilder(BuildContext context, String value) {
    return Builder(builder: (context) {
      final style = DefaultTextStyle.of(context).style;
      final TextDirection directionality = Directionality.of(context);
      return Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text(
          value,
          maxLines: 1,
          softWrap: false,
          style: style,
          textDirection: directionality,
        ),
      );
    });
  }
}

class _XpCheckboxState extends State<XpCheckbox> {
  double? _labelWidth;
  bool _hover = false;

  void _updateLabelWidth() {
    final style = DefaultTextStyle.of(context).style;
    final TextDirection directionality = Directionality.of(context);
    const WidgetSurveyor widgetSurveyor = WidgetSurveyor();
    Widget item = Directionality(
      textDirection: directionality,
      child: DefaultTextStyle(
          style: style,
          child: XpCheckbox.defaultItemBuilder(context, widget.label)),
    );
    _labelWidth = widgetSurveyor.measureWidget(item).width;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateLabelWidth();
  }

  @override
  void didUpdateWidget(covariant XpCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateLabelWidth();
  }

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context);
    final isEnabled = widget.onChanged != null;
    return MouseRegion(
      onEnter: (event) => setState(() => _hover = true),
      onExit: (event) => setState(() => _hover = false),
      child: SizedBox(
        width: _labelWidth! + _kDefaultCheckboxSize + (_kDefaultSpacing * 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: _kDefaultSpacing,
            ),
            DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: !isEnabled
                            ? theme.checkboxTheme.disabledColor ??
                                theme.colorScheme.disabledColor
                            : theme.checkboxTheme.borderColor ??
                                theme.colorScheme.borderControlColor),
                    color: isEnabled
                        ? null
                        : theme.checkboxTheme.backgroundColor ??
                            theme.colorScheme.controlsBackgroundColor,
                    gradient: !isEnabled
                        ? null
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                                const Color(0xffdcdcd7),
                                theme.checkboxTheme.backgroundColor ??
                                    theme.colorScheme.controlsBackgroundColor
                              ])),
                child: SizedBox(
                  height: _kDefaultCheckboxSize,
                  width: _kDefaultCheckboxSize,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        boxShadow: _hover && isEnabled
                            ? [
                                BoxShadow(
                                    inset: true,
                                    offset: const Offset(-1, 1),
                                    color: theme.buttonStyle!.hoverColorTop),
                                BoxShadow(
                                    inset: true,
                                    offset: const Offset(1, 2),
                                    color: theme.buttonStyle!.hoverColorRight),
                                BoxShadow(
                                    inset: true,
                                    offset: const Offset(-2, 2),
                                    color: theme.buttonStyle!.hoverColorLeft),
                                BoxShadow(
                                    inset: true,
                                    offset: const Offset(2, -2),
                                    color: theme.buttonStyle!.hoverColorBottom)
                              ]
                            : []),
                    child: widget.value
                        ? Icon(
                            Icons.check,
                            size: _kDefaultCheckboxSize * 0.9,
                            color: theme.checkboxTheme.checkColor ??
                                theme.colorScheme.accentColor,
                          )
                        : null,
                  ),
                )),
            const SizedBox(
              width: _kDefaultSpacing,
            ),
            Text(
              widget.label,
              style: TextStyle(
                  color: isEnabled ? null : theme.colorScheme.disabledColor),
            )
          ],
        ),
      ),
    );
  }
}
