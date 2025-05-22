import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/colors.dart';
import 'package:xp_ui/xp_ui.dart';
import 'dart:math' as math;

const double _progressItemWidth = 11;
const double _padding = 2;

class ProgressBar extends StatelessWidget {
  const ProgressBar(
      {super.key,
      this.value,
      this.height = 16,
      this.trackColor,
      this.backgroundColor,
      this.semanticLabel});

  /// The value of the progress bar. If non-null, this has to
  /// be non-negative and less the 100. If null, the progress bar
  /// will be considered indeterminate.
  final double? value;

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
    final style = XpTheme.of(context).progressBarTheme;
    return Semantics(
      label: semanticLabel,
      value: value?.toStringAsFixed(2),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: height, minHeight: height, minWidth: 80),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(
                  color: style.borderColor,
                  strokeAlign: BorderSide.strokeAlignOutside),
              borderRadius: const BorderRadius.all(Radius.circular(3))),
          child: value == null
              ? RepaintBoundary(child: _ProgressIndeterminatedBarWidget())
              : CustomPaint(
                  painter: _ProgressDeterminatedBarPainter(
                    value!,
                    backgroundColor: style.backgroundColor,
                    activeColor: style.trackColor,
                  ),
                ),
        ),
      ),
    );
  }
}

class _ProgressDeterminatedBarPainter extends CustomPainter {
  const _ProgressDeterminatedBarPainter(
    this.value, {
    required this.backgroundColor,
    required this.activeColor,
  });
  final double value;
  final Color backgroundColor;
  final Color activeColor;
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundRect =
        const BorderRadius.all(Radius.circular(3)).toRRect(Offset.zero & size);
    canvas.drawRRect(
        backgroundRect,
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill);
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
    final gradient = LinearGradient(
            colors: [XpColors.white, activeColor, XpColors.white],
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

class _ProgressIndeterminatedBarWidget extends StatefulWidget {
  @override
  State<_ProgressIndeterminatedBarWidget> createState() =>
      _ProgressIndeterminatedBarWidgetState();
}

class _ProgressIndeterminatedBarWidgetState
    extends State<_ProgressIndeterminatedBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double p1 = 0, p2 = 0;
  double idleFrames = 15, cycle = 1, idle = 1;
  double lastValue = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant _ProgressIndeterminatedBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_controller.isAnimating) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context).progressBarTheme;

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          var deltaValue = _controller.value - lastValue;
          lastValue = _controller.value;
          if (deltaValue < 0) deltaValue++; //
          return CustomPaint(
            painter: _ProgressIndeterminatedBarPainter(
              p1: p1,
              idle: idle,
              cycle: cycle,
              idleFrames: idleFrames,
              deltaValue: deltaValue,
              onUpdate: (List<double> values) {
                p1 = values[0];
                idleFrames = values[1];
                cycle = values[2];
                idle = values[3];
              },
              backgroundColor: theme.backgroundColor,
              activeColor: theme.trackColor,
            ),
          );
        });
  }
}

class _ProgressIndeterminatedBarPainter extends CustomPainter {
  _ProgressIndeterminatedBarPainter({
    required this.p1,
    required this.idle,
    required this.cycle,
    required this.idleFrames,
    required this.deltaValue,
    required this.onUpdate,
    required this.backgroundColor,
    required this.activeColor,
  });
  final Color backgroundColor;
  final Color activeColor;
  static const _step1 = 2.7,
      _velocityScale = 0.8; // percentage of long line (0..1)

  double p1, idleFrames, cycle, idle, deltaValue;

  final ValueChanged<List<double>> onUpdate;

  @override
  void paint(Canvas canvas, Size size) {
    size = Size(size.width - 2, size.height - 2);
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final backgroundRect =
        const BorderRadius.all(Radius.circular(3)).toRRect(Offset.zero & size);
    canvas.drawRRect(
        backgroundRect,
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill);
    void drawLine(Offset xy1) {
      final gradient = LinearGradient(
              colors: [XpColors.white, activeColor, XpColors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      final Paint paint = Paint()..shader = gradient;
      canvas.drawRect(
          Rect.fromLTWH(
              (xy1.dx), _padding, _progressItemWidth, size.height - _padding),
          paint);
      canvas.drawRect(
          Rect.fromLTWH((xy1.dx + _padding + _progressItemWidth), _padding,
              _progressItemWidth, size.height - _padding),
          paint);
      canvas.drawRect(
          Rect.fromLTWH((xy1.dx + (_padding * 2) + (_progressItemWidth * 2)),
              _padding, _progressItemWidth, size.height - _padding),
          paint);
    }

    void update() {
      onUpdate([p1, idleFrames, cycle, idle]);
    }

    Offset coords(double percentage) {
      return Offset(
        size.width * percentage,
        size.height,
      );
    }

    double calcVelocity(double p) {
      return (1 + math.cos(math.pi * p - (math.pi / 2)) * _velocityScale) *
          deltaValue;
    }

    final v1 = calcVelocity(p1);

    p1 = math.min(p1 + _step1 * v1, 1);
    if (p1 == 1) {
      // the end reached
      idle = idleFrames;
      cycle *= -1;
      p1 = 0;
    }
    update();

    if (idle != 0) drawLine(coords(p1));
  }

  @override
  bool shouldRepaint(covariant _ProgressIndeterminatedBarPainter old) => true;
}
