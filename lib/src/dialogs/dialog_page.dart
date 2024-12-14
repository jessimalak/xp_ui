import 'package:flutter/widgets.dart';

class XpDialogRoute<T> extends PopupRoute<T> {
  XpDialogRoute({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = false,
    Color? barrierColor = const Color(0x00000000),
    String? barrierLabel,
    super.settings,
  })  : _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _barrierColor = barrierColor;

  final RoutePageBuilder _pageBuilder;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String? get barrierLabel => _barrierLabel;
  final String? _barrierLabel;

  @override
  Color? get barrierColor => _barrierColor;
  final Color? _barrierColor;

  @override
  Curve get barrierCurve => Curves.linear;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 1);

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: _pageBuilder(context, animation, secondaryAnimation),
    );
  }
}
