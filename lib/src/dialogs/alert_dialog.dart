import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/dialogs/dialog_page.dart';
import 'package:xp_ui/xp_ui.dart';

const _kDefaultDialogConstraints = BoxConstraints(
  minWidth: 260,
  maxWidth: 260,
);

const double _kDefaultBorderWidth = 3;

class XpAlertDialog extends StatelessWidget {
  const XpAlertDialog(
      {super.key, required this.title, this.content, this.actions = const [], this.showCloseButton = true});
  final String title;
  final Widget? content;
  final List<Button> actions;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context);
    return Dialog(
      backgroundColor: theme.backgroundColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(6))),
      clipBehavior: Clip.hardEdge,
      child: ConstrainedBox(
        constraints: _kDefaultDialogConstraints,
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
                      left: BorderSide(color: theme.accentColor, width: _kDefaultBorderWidth),
                      bottom: BorderSide(color: theme.titleBarStyle.backgroundShade3, width: _kDefaultBorderWidth),
                      right: BorderSide(color: theme.titleBarStyle.backgroundShade3, width: _kDefaultBorderWidth))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  content ??
                      const SizedBox(
                        height: 56,
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions,
                  )
                ],
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
  return Navigator.of(context, rootNavigator: useRootNavigator).push<T>(XpDialogRoute(
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel ?? MaterialLocalizations.of(context).modalBarrierDismissLabel));
}
