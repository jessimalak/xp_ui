import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xp_ui/src/controls/title_bar.dart';
import 'package:xp_ui/src/layout/scrollbar.dart';
import 'package:xp_ui/src/layout/sidebar/sidebar.dart';
import 'package:xp_ui/src/styles/colors.dart';
import 'package:xp_ui/src/styles/theme/theme.dart';
import 'dart:math' as math;

// BASED ON macos_ui's MacosWindow Widget https://github.com/macosui/macos_ui/blob/dev/lib/src/layout/window.dart

class XpWindow extends StatefulWidget {
  const XpWindow({
    super.key,
    this.backgroundColor,
    this.child,
    this.titleBar,
    this.sidebar,
  });

  /// Specifies the background color for the Window.
  ///
  /// The default colors from the theme would be used if no color is specified.
  final Color? backgroundColor;

  /// The child of the [XpWindow]
  final Widget? child;

  /// An app bar to display at the top of the window.
  final TitleBar? titleBar;

  /// A sidebar to display at the left of the window.
  final Sidebar? sidebar;

  @override
  State<XpWindow> createState() => _XpWindowState();
}

class _XpWindowState extends State<XpWindow> {
  var _sidebarScrollController = ScrollController();
  double _sidebarWidth = 0.0;
  double _sidebarDragStartWidth = 0.0;
  double _sidebarDragStartPosition = 0.0;
  late bool _showSidebar = widget.sidebar?.shownByDefault ?? true;
  int _sidebarSlideDuration = 0;
  SystemMouseCursor _sidebarCursor = SystemMouseCursors.resizeColumn;

  @override
  void initState() {
    super.initState();
    _sidebarWidth = (widget.sidebar?.startWidth ?? widget.sidebar?.minWidth) ??
        _sidebarWidth;
    _addSidebarScrollControllerListenerIfNeeded();
  }

  void _addSidebarScrollControllerListenerIfNeeded() {
    if (widget.sidebar?.builder != null) {
      _sidebarScrollController.addListener(() => setState(() {}));
    }
  }

  @override
  void didUpdateWidget(covariant XpWindow old) {
    super.didUpdateWidget(old);
    final sidebar = widget.sidebar;
    if (sidebar == null) {
      _sidebarWidth = 0.0;
    } else if (sidebar.minWidth != old.sidebar!.minWidth ||
        sidebar.maxWidth != old.sidebar!.maxWidth) {
      if (sidebar.minWidth > _sidebarWidth) {
        _sidebarWidth = sidebar.minWidth;
      }
      if (sidebar.maxWidth! < _sidebarWidth) {
        _sidebarWidth = sidebar.maxWidth!;
      }
    }
    if (sidebar?.key != old.sidebar?.key) {
      _sidebarScrollController.dispose();
      _sidebarScrollController = ScrollController();
      _addSidebarScrollControllerListenerIfNeeded();
    }
  }

  @override
  void dispose() {
    _sidebarScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sidebar = widget.sidebar;
    if (sidebar?.startWidth != null) {
      assert((sidebar!.startWidth! >= sidebar.minWidth) &&
          (sidebar.startWidth! <= sidebar.maxWidth!));
    }
    const curve = Curves.linearToEaseOut;
    final duration = Duration(milliseconds: _sidebarSlideDuration);
    final XpThemeData theme = XpTheme.of(context);
    late Color backgroundColor =
        widget.backgroundColor ?? theme.colorScheme.backgroundColor;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      final isAtBreakpoint = width <= (sidebar?.windowBreakpoint ?? 0);
      final canShowSidebar = _showSidebar && !isAtBreakpoint && sidebar != null;
      final visibleSidebarWidth = canShowSidebar ? _sidebarWidth : 0.0;
      final layout = Stack(
        children: [
          //Background color
          AnimatedPositioned(
            curve: curve,
            duration: duration,
            height: height,
            left: visibleSidebarWidth,
            width: width,
            child: ColoredBox(color: backgroundColor),
          ),

          //Sidebar
          if (sidebar != null)
            AnimatedPositioned(
                key: sidebar.key,
                duration: duration,
                curve: curve,
                height: height,
                width: _sidebarWidth,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          theme.sidebarTheme.startColor,
                          theme.sidebarTheme.endColor
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0, 0.5]),
                  ),
                  constraints: BoxConstraints(
                          minWidth: sidebar.minWidth,
                          maxWidth: sidebar.maxWidth!,
                          minHeight: height,
                          maxHeight: height)
                      .normalize(),
                  child: Column(
                    children: [
                      // If an app is running on macOS, apply
                      // sidebar.topOffset as needed in order to avoid
                      // the traffic lights. Otherwise, position the
                      // sidebar by the top of the application's bounds
                      // based on the presence of sidebar.top.
                      if (!kIsWeb && sidebar.topOffset > 0) ...[
                        SizedBox(height: sidebar.topOffset),
                      ] else if (sidebar.top != null) ...[
                        const SizedBox(height: 12),
                      ] else
                        const SizedBox.shrink(),
                      Expanded(
                        child: XpScrollbar(
                          controller: _sidebarScrollController,
                          child: Padding(
                            padding: sidebar.padding,
                            child: sidebar.builder(
                              context,
                              _sidebarScrollController,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )), // Sidebar resizer
          if (sidebar?.isResizable ?? false)
            AnimatedPositioned(
              curve: curve,
              duration: duration,
              left: visibleSidebarWidth - 4,
              width: 7,
              height: height,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragStart: (details) {
                  _sidebarDragStartWidth = _sidebarWidth;
                  _sidebarDragStartPosition = details.globalPosition.dx;
                },
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    var newWidth = _sidebarDragStartWidth +
                        details.globalPosition.dx -
                        _sidebarDragStartPosition;

                    if (sidebar!.startWidth != null &&
                        sidebar.snapToStartBuffer != null &&
                        (newWidth - sidebar.startWidth!).abs() <=
                            sidebar.snapToStartBuffer!) {
                      newWidth = sidebar.startWidth!;
                    }

                    if (sidebar.dragClosed) {
                      final closeBelow =
                          sidebar.minWidth - sidebar.dragClosedBuffer;
                      _showSidebar = newWidth >= closeBelow;
                    }

                    _sidebarWidth = math.max(
                      sidebar.minWidth,
                      math.min(
                        sidebar.maxWidth!,
                        newWidth,
                      ),
                    );

                    if (_sidebarWidth == sidebar.minWidth) {
                      _sidebarCursor = SystemMouseCursors.resizeRight;
                    } else if (_sidebarWidth == sidebar.maxWidth) {
                      _sidebarCursor = SystemMouseCursors.resizeLeft;
                    } else {
                      _sidebarCursor = SystemMouseCursors.resizeColumn;
                    }
                  });
                },
                child: MouseRegion(
                  cursor: _sidebarCursor,
                  child: const Align(
                    alignment: Alignment.center,
                    child: VerticalDivider(
                      thickness: 1,
                      width: 1,
                      color: XpColors.white,
                    ),
                  ),
                ),
              ),
            ),
          // Content Area
          AnimatedPositioned(
            curve: curve,
            duration: duration,
            left: visibleSidebarWidth,
            width: width - visibleSidebarWidth,
            height: height,
            child: ClipRect(
              child: Padding(
                padding: EdgeInsets.only(
                  top: widget.titleBar != null ? 32 : 0,
                ),
                child: widget.child ?? const SizedBox.shrink(),
              ),
            ),
          ),
          // Title bar Area
          Positioned(
            left: 0,
            width: width,
            height: 32,
            child: ClipRect(
              child: widget.titleBar ?? const SizedBox.shrink(),
            ),
          ),
        ],
      );

      return XpWindowScope(
          constraints: constraints,
          isSidebarShown: canShowSidebar,
          sidebarToggler: () async {
            setState(() => _sidebarSlideDuration = 300);
            setState(() => _showSidebar = !_showSidebar);
            await Future.delayed(Duration(milliseconds: _sidebarSlideDuration));
            if (mounted) {
              setState(() => _sidebarSlideDuration = 0);
            }
          },
          child: layout);
    });
  }
}

/// A [XpWindowScope] serves as a scope for its descendants to rely on
/// values needed for the layout of the descendants.
///
/// It is embedded in the [XpWindow] and available to the widgets just below
/// it in the widget tree. The [XpWindowScope] passes down the values which
/// are calculated inside [XpWindow] to its descendants.
///
/// Descendants of the [XpWindowScope] automatically work with the values
/// they need, so you will hardly need to manually use the [XpWindowScope].
class XpWindowScope extends InheritedWidget {
  /// Creates a widget that manages the layout of the [XpWindow].
  ///
  /// [ResizablePane] and [ContentArea] are other widgets that depend
  /// on the [XpWindowScope] for layout.
  ///
  /// The [constraints], [contentAreaWidth], [child], [valueNotifier]
  /// and [_scaffoldState] arguments are required and must not be null.
  const XpWindowScope({
    super.key,
    required this.constraints,
    required super.child,
    required this.isSidebarShown,
    required VoidCallback sidebarToggler,
  }) : _sidebarToggler = sidebarToggler;

  /// Provides the constraints from the [XpWindow] to its descendants.
  final BoxConstraints constraints;

  /// Provides a callback which will be used to privately toggle the sidebar.
  final Function _sidebarToggler;

  /// Returns the [XpWindowScope] of the [XpWindow] that most tightly encloses
  /// the given [context].
  ///
  /// If the [context] does not have a [XpWindow] as its ancestor, an assertion
  /// is thrown.
  ///
  /// The [context] argument must not be null.
  static XpWindowScope of(BuildContext context) {
    final XpWindowScope? result =
        context.dependOnInheritedWidgetOfExactType<XpWindowScope>();
    assert(result != null, 'No XpWindowScope found in context');
    return result!;
  }

  /// Returns a [XpWindowScope] of the [XpWindow] that most tightly
  /// encloses the given [context]. The result can be null.
  ///
  /// If this [context] does not have a [XpWindow] as its ancestor, the result
  /// returned is null.
  ///
  /// The [context] argument must not be null.
  static XpWindowScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<XpWindowScope>();
  }

  /// Provides the current visible state of the [Sidebar].
  final bool isSidebarShown;

  /// Toggles the [Sidebar] of the [XpWindow].
  ///
  /// This does not change the current width of the [Sidebar]. It only
  /// hides or shows it.
  void toggleSidebar() {
    _sidebarToggler();
  }

  @override
  bool updateShouldNotify(XpWindowScope oldWidget) {
    return constraints != oldWidget.constraints ||
        isSidebarShown != oldWidget.isSidebarShown;
  }
}
