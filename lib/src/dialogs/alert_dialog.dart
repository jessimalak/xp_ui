import 'package:flutter/material.dart';
import 'package:xp_ui/src/dialogs/dialog_page.dart';
import 'package:xp_ui/xp_ui.dart';

const double _kDefaultBorderWidth = 3;

enum AlertType { error, success, warning, info, question,none }

class XpAlertDialog extends StatelessWidget {
  const XpAlertDialog(
      {super.key,
      required this.title,
      this.content,
      this.actions = const [],
      this.showCloseButton = true,
      this.alerType = AlertType.none});
  final String title;
  final Widget? content;
  final List<Button> actions;
  final bool showCloseButton;
  final AlertType alerType;

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context);
    final child = Flexible(
      child: content ??
          const SizedBox(
            height: 56,
          ),
    );
    return Dialog(
      backgroundColor: theme.colorScheme.backgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(6))),
      clipBehavior: Clip.hardEdge,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleBar.dialog(
              title,
              showCloseButton: showCloseButton,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: theme.colorScheme.primaryColor,
                          width: _kDefaultBorderWidth),
                      bottom: BorderSide(
                          color: theme.titleBarTheme.backgroundShade3,
                          width: _kDefaultBorderWidth),
                      right: BorderSide(
                          color: theme.titleBarTheme.backgroundShade3,
                          width: _kDefaultBorderWidth))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    alerType == AlertType.none
                        ? child
                        : Row(mainAxisSize: MainAxisSize.min,
                            children: [
                              SystemIcon(
                                  icon: switch (alerType) {
                                AlertType.error => XpSystemIcons.error,
                                AlertType.warning => XpSystemIcons.warning,
                                AlertType.success => XpSystemIcons.shieldSuccess,
                                AlertType.question => XpSystemIcons.question,
                                _ => XpSystemIcons.info1
                              }),
                              const SizedBox(
                                width: 16,
                              ),
                              child
                            ],
                          ),
                    if (actions.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: actions
                              .expand((button) sync* {
                                yield const SizedBox(
                                  width: 8,
                                );
                                yield button;
                              })
                              .skip(1)
                              .toList(),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<T?> showXpDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = false,
  Color? barrierColor,
  String? barrierLabel,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
}) {
  return Navigator.of(context, rootNavigator: useRootNavigator).push<T>(
      XpDialogRoute(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          barrierColor: barrierColor,
          barrierDismissible: barrierDismissible,
          barrierLabel: barrierLabel ??
              MaterialLocalizations.of(context).modalBarrierDismissLabel));
}
