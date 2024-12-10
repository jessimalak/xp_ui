import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/controls/styles/colors.dart';
import 'package:xp_ui/src/controls/styles/theme.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar(
      {super.key,
      required this.value,
      this.height = 16,
      this.trackColor,
      this.backgroundColor,
      this.semanticLabel});

  /// The value of the progress bar. If non-null, this has to
  /// be non-negative and less the 100. If null, the progress bar
  /// will be considered indeterminate.
  final double value;

  /// The height of the line. Default to 4.5px
  final double height;

  /// The color of the track. If null, [MacosThemeData.accentColor] is used
  final Color? trackColor;

  /// The color of the background. If null, [CupertinoColors.secondarySystemFill]
  /// is used
  final Color? backgroundColor;

  /// The semantic label used by screen readers.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final xpThemeData = XpTheme.of(context);
    return Semantics(
      label: semanticLabel,
      value: value.toStringAsFixed(2),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: height, minHeight: height, minWidth: 80),
        child: CustomPaint(
          painter: _ProgressDeterminatedBarPainter(value,
              backgroundColor: xpThemeData.progressBarStyle.backgroundColor,
              activeColor: xpThemeData.progressBarStyle.trackColor),
        ),
      ),
    );
  }
}

class _ProgressDeterminatedBarPainter extends CustomPainter {
  static const double _progressItemWidth = 11;
  static const double _padding = 2;
  const _ProgressDeterminatedBarPainter(this.value,
      {this.backgroundColor, this.activeColor});
  final double value;
  final Color? backgroundColor;
  final Color? activeColor;
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundRect =
        const BorderRadius.all(Radius.circular(3)).toRRect(Offset.zero & size);
    canvas.drawRRect(
        backgroundRect,
        Paint()
          ..color = backgroundColor ?? XpColors.white
          ..style = PaintingStyle.fill);
    canvas.drawRRect(
        backgroundRect,
        Paint()
          ..color = XpColors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.5);
    final double totalProgressItems =
        size.width / (_progressItemWidth + _padding);
    double extraWidth = 0;
    if (totalProgressItems * (_progressItemWidth + _padding) < size.width) {
      extraWidth = (size.width -
              (totalProgressItems * _progressItemWidth) -
              (totalProgressItems * (_padding * 2))) /
          totalProgressItems;
    }
    final int currentProgressItems =
        (totalProgressItems * (value / 100)).round();
    final double progressItemHeight = size.height - _padding * 2;
    final progressItemWidth = _progressItemWidth + extraWidth;
    final gradient = const LinearGradient(
            colors: [XpColors.white, XpColors.green, XpColors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)
        .createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final Paint paint = Paint()..shader = gradient;
    for (int i = 0; i < currentProgressItems; i++) {
      if (i == 0) {
        canvas.drawRRect(
            const BorderRadius.horizontal(left: Radius.circular(4)).toRRect(
                Rect.fromLTWH(_padding + 3, _padding, progressItemWidth - 2,
                    progressItemHeight)),
            paint);
      }
      if (i == currentProgressItems - 1) {
        canvas.drawRRect(
            const BorderRadius.horizontal(right: Radius.circular(4)).toRRect(
                Rect.fromLTWH((progressItemWidth + _padding) * i + 3, _padding,
                    progressItemWidth, progressItemHeight)),
            paint);
      }

      canvas.drawRect(
          Rect.fromLTWH((progressItemWidth + _padding) * i + 3, _padding,
              progressItemWidth, progressItemHeight),
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressDeterminatedBarPainter old) =>
      old.value != value;
}
