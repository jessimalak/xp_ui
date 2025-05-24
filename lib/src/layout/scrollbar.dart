import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/colors.dart';
import 'package:xp_ui/src/styles/theme/theme.dart';

const double _kScrollbarMinLength = 36.0;
const double _kScrollbarMinOverscrollLength = 8.0;
const double _kScrollbarMainAxisMargin = 3.0;
const double _kScrollbarCrossAxisMargin = 2.0;

class XpScrollbar extends StatelessWidget {
  const XpScrollbar({
    super.key,
    required this.child,
    this.controller,
    this.thickness,
    this.thicknessWhileHovering,
    this.radius,
    this.notificationPredicate,
    this.scrollbarOrientation,
  });

  final Widget child;

  /// {@macro flutter.widgets.Scrollbar.controller}
  final ScrollController? controller;

  /// The thickness of the scrollbar in the cross axis of the scrollable.
  ///
  /// Defaults to 6.0.
  final double? thickness;

  /// The thickness of the scrollbar in the cross axis of the scrollable while
  /// the mouse cursor is hovering over the scrollbar.
  ///
  /// Defaults to 9.0.
  final double? thicknessWhileHovering;

  /// The [Radius] of the scrollbar thumb's rounded rectangle corners.
  ///
  /// Defaults to `const Radius.circular(25)`.
  final Radius? radius;

  /// {@macro flutter.widgets.Scrollbar.notificationPredicate}
  final ScrollNotificationPredicate? notificationPredicate;

  /// {@macro flutter.widgets.Scrollbar.scrollbarOrientation}
  final ScrollbarOrientation? scrollbarOrientation;

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context).scrollbarTheme;
    return _XpRawScrollbar(
        effectiveThumbColor: theme.thumbColor,
        thickness: thickness ?? theme.thickness,
        notificationPredicate: notificationPredicate,
        scrollbarOrientation: scrollbarOrientation,
        radius: radius ?? theme.radius,
        controller: controller,
        trackColor: theme.backgroundColor,
        child: child);
  }
}

class _XpRawScrollbar extends RawScrollbar {
  const _XpRawScrollbar(
      {super.controller,
      super.thickness,
      ScrollNotificationPredicate? notificationPredicate,
      super.scrollbarOrientation,
      required this.effectiveThumbColor,
      required super.child,
      super.trackColor,
      super.radius})
      : super(notificationPredicate: notificationPredicate ?? defaultScrollNotificationPredicate);
  final Color effectiveThumbColor;

  @override
  bool? get thumbVisibility => true;

  @override
  RawScrollbarState<RawScrollbar> createState() => _XpRawScrollbarState();
}

class _XpRawScrollbarState extends RawScrollbarState<_XpRawScrollbar> {
  @override
  void updateScrollbarPainter() {
    scrollbarPainter
      ..color = widget.effectiveThumbColor
      ..trackColor = widget.trackColor ?? XpColors.white
      ..textDirection = Directionality.of(context)
      ..thickness = widget.thickness ?? 14
      ..mainAxisMargin = _kScrollbarMainAxisMargin
      ..crossAxisMargin = _kScrollbarCrossAxisMargin
      ..radius = widget.radius
      ..padding = MediaQuery.paddingOf(context)
      ..minLength = _kScrollbarMinLength
      ..minOverscrollLength = _kScrollbarMinOverscrollLength
      ..scrollbarOrientation = widget.scrollbarOrientation;
  }

}
