import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/styles/colors.dart';
import 'package:xp_ui/xp_ui.dart';

class TitleBar extends StatelessWidget {
  final String title;
  const TitleBar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final mainColor = XpTheme.of(context).titleBarColor;
    final HSLColor color = HSLColor.fromColor(mainColor);
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                  width: 0.5,
                    color: color
                        .withHue(color.hue + 13)
                        .withSaturation(color.saturation - 0.04)
                        .withLightness(color.lightness - 0.15)
                        .toColor())),
            gradient: LinearGradient(
                colors: [
                  color
                      .withHue(color.hue - 11)
                      .withSaturation(color.saturation - 0.04)
                      .toColor(),
                  color
                      .withHue(color.hue + 3)
                      .withLightness(color.lightness - 0.07)
                      .toColor(),
                  color
                      .withHue(color.hue + 4)
                      .withLightness(color.lightness - 0.07)
                      .toColor(),
                  mainColor,
                  mainColor,
                  color.withHue(color.hue - 4).toColor(),
                  color
                      .withHue(color.hue + 7)
                      .withLightness(color.lightness - 0.16)
                      .toColor(),
                  color
                      .withHue(color.hue + 7)
                      .withLightness(color.lightness - 0.16)
                      .toColor()
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.03, .08, .40, .88, .93, .95, .96, 1])),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(3, 5, 3, 3),
          child: Text(
            title,
            style: const TextStyle(color: XpColors.white, fontSize: 13),
          ),
        ),
      ),
    );
  }
}
