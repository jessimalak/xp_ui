import 'package:flutter/widgets.dart';
import 'package:xp_ui/src/layout/tab_view/tab.dart';
import 'package:xp_ui/src/layout/tab_view/tab_view_controller.dart';
import 'package:xp_ui/src/styles/theme.dart';

class XpTabView extends StatefulWidget {
  const XpTabView(
      {super.key,
      required this.controller,
      required this.tabs,
      required this.children})
      : assert(controller.length == children.length &&
            controller.length == tabs.length);
  final List<XpTab> tabs;
  final List<Widget> children;
  final XpTabViewController controller;

  @override
  State<XpTabView> createState() => _XpTabViewState();
}

class _XpTabViewState extends State<XpTabView> {
  late List<Widget> _childrenWithKey;
  int? _currentIndex;

  @override
  void initState() {
    super.initState();
    _updateChildren();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
    _currentIndex = widget.controller.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant XpTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
      _currentIndex = widget.controller.selectedIndex;
    }
    if (widget.children != oldWidget.children) {
      _updateChildren();
    }
  }

  void _updateChildren() {
    _childrenWithKey = KeyedSubtree.ensureUniqueKeysForList(widget.children);
  }

  void _updateTabController() {
    widget.controller.addListener(_handleTabControllerTick);
  }

  void _handleTabControllerTick() {
    if (widget.controller.selectedIndex != _currentIndex) {
      _currentIndex = widget.controller.selectedIndex;
    }
    setState(() {
      // Rebuild the children after an index change
      // has completed.
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTabControllerTick);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = XpTheme.of(context);
    LayoutBuilder layoutBuilder =
        LayoutBuilder(builder: (context, constraints) {
      return SizedBox.shrink();
    });
    return layoutBuilder;
  }
}
