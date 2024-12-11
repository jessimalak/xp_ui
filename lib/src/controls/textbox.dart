import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/rendering/object.dart';
import 'package:xp_ui/src/styles/colors.dart';
import 'package:xp_ui/xp_ui.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class Textbox extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context).textBoxStyle;
    return _RawTextBox(
      textfield: DecoratedBox(
        decoration: BoxDecoration(border: Border.all(color: theme.borderColor)),
        child: TextField(
          controller: controller,
          style: TextStyle(fontSize: 12, height: 1, color: theme.textStyle.color),
          decoration: const InputDecoration(
              hintText: 'Hint Textbox',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 0), ),
        ),
      ),
      hint: labelWidget ??
          SizedBox(
            width: 1,
            height: 1,
          ),
      hintPosition: labelPosition,
    );
  }
}

enum TextboxLabelPosition {
  left,
  top;
}

class _RawTextBox extends RenderObjectWidget {
  final Widget textfield;
  final Widget hint;
  final TextboxLabelPosition hintPosition;

  const _RawTextBox(
      {super.key,
      required this.textfield,
      required this.hint,
      required this.hintPosition});
  @override
  RenderObjectElement createElement() => _TextBoxElement(this);

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderTextfield();
}

class _TextBoxElement extends RenderObjectElement {
  _TextBoxElement(_RawTextBox super.widget);
  Element? _textfield;
  Element? _hint;

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_textfield != null) visitor(_textfield!);
    if (_hint != null) visitor(_hint!);
  }

  @override
  _RawTextBox get widget => super.widget as _RawTextBox;

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    renderObject.hintPosition = widget.hintPosition;
    _textfield = updateChild(_textfield, widget.textfield, _Slot.textfield);
    _hint = updateChild(_hint, widget.hint, _Slot.hint);
  }

  @override
  void update(covariant RenderObjectWidget newWidget) {
    super.update(newWidget);
    renderObject.hintPosition = widget.hintPosition;
    _textfield = updateChild(_textfield, widget.textfield, _Slot.textfield);
    _hint = updateChild(_hint, widget.hint, _Slot.hint);
  }

  @override
  _RenderTextfield get renderObject => super.renderObject as _RenderTextfield;

  @override
  void insertRenderObjectChild(
      covariant RenderBox child, covariant _Slot slot) {
    switch (slot) {
      case _Slot.textfield:
        renderObject.textfield = child;
        break;
      case _Slot.hint:
        renderObject.hint = child;
    }
  }

  @override
  void moveRenderObjectChild(covariant RenderObject child,
      covariant Object? oldSlot, covariant Object? newSlot) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(
      covariant RenderObject child, covariant Object? slot) {
    switch (slot) {
      case _Slot.textfield:
        renderObject.textfield = null;
        break;
      case _Slot.hint:
        renderObject.hint = null;
      default:
    }
  }

  @override
  void forgetChild(Element child) {
    switch (slot) {
      case _Slot.textfield:
        _textfield = null;
        break;
      case _Slot.hint:
        _hint = null;
      default:
    }
    super.forgetChild(child);
  }
}

enum _Slot { textfield, hint }

class _RenderTextfield extends RenderBox {
  TextboxLabelPosition hintPosition = TextboxLabelPosition.top;
  RenderBox? _textfield;
  RenderBox? get textfield => _textfield;
  set textfield(RenderBox? value) {
    if (value == _textfield) return;
    if (_textfield != null) dropChild(_textfield!);
    _textfield = value;
    if (_textfield != null) adoptChild(_textfield!);
  }

  RenderBox? _hint;
  RenderBox? get hint => _hint;
  set hint(RenderBox? value) {
    if (value == _hint) return;
    if (_hint != null) dropChild(_hint!);
    _hint = value;
    if (_hint != null) adoptChild(_hint!);
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    if (textfield != null) textfield!.attach(owner);
    if (hint != null) hint!.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    if (textfield != null) textfield!.detach();
    if (hint != null) hint!.detach();
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    if (textfield != null) visitor(textfield!);
    if (hint != null) visitor(hint!);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (RenderBox? child in [textfield, hint]) {
      if (child != null) {
        final BoxParentData parentData = child.parentData as BoxParentData;
        final bool isHit = result.addWithPaintOffset(
          offset: parentData.offset,
          position: position,
          hitTest: (BoxHitTestResult result, Offset transformed) {
            assert(transformed == position - parentData.offset);
            return child.hitTest(result, position: transformed);
          },
        );
        if (isHit) {
          return true;
        }
      }
    }

    return false;
  }

  double hintSize = 0;

  @override
  void performLayout() {
    BoxConstraints boxConstraints = const BoxConstraints();
    if (hintPosition == TextboxLabelPosition.left) {
      hintSize = math.min(hint!.getMaxIntrinsicWidth(double.infinity),
          math.max(constraints.maxWidth - 3, 0));
      boxConstraints =
          constraints.deflate(EdgeInsets.only(left: hintSize + 3, top: 2));
    } else {
      hintSize = math.min(hint!.getMaxIntrinsicHeight(double.infinity),
          math.max(constraints.maxHeight - 3, 0));
      boxConstraints =
          constraints.deflate(EdgeInsets.only(left: 3, top: hintSize + 2));
    }
    _textfield!.layout(boxConstraints, parentUsesSize: true);
    size = constraints.constrain(Size(
        _textfield!.size.width +
            (hintPosition == TextboxLabelPosition.top ? 0 : hintSize),
        _textfield!.size.height +
            (hintPosition == TextboxLabelPosition.left ? 0 : hintSize)));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final parentData = textfield!.parentData as BoxParentData;
    final fieldWidth = textfield!.size.width;
    // final Size hintSize = hint!.size;
    ui.Paint bgPain = ui.Paint()..color = XpColors.white;
    final Rect bgRect = Rect.fromLTWH(
        offset.dx + (hintPosition == TextboxLabelPosition.top ? 0 : hintSize),
        offset.dy + (hintPosition == TextboxLabelPosition.left ? 0 : hintSize),
        fieldWidth,
        size.height -
            (hintPosition == TextboxLabelPosition.left ? 0 : hintSize));
    context.canvas.drawRect(bgRect, bgPain);
    if (hintPosition == TextboxLabelPosition.top) {
      context.paintChild(_hint!, offset + parentData.offset);
      context.paintChild(
          _textfield!,
          Offset(offset.dx + parentData.offset.dx,
              offset.dy + parentData.offset.dy + hintSize));
    } else {
      context.paintChild(_hint!, offset + parentData.offset);
      context.paintChild(
          _textfield!,
          Offset(offset.dx + parentData.offset.dx + hintSize,
              offset.dy + parentData.offset.dy));
    }
  }
}
