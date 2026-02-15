## 0.3.0
* Breaking changes
    * `StatusBar` _rightChildren_ parameter renamed to trailing.
    * Removed `window_manager` package of `TitleBar` widget.
    * Removed `TitleBar` widget parameters:
        * _showCloseButton_
        * _showMaximizeButton_
        * _showMinimizeButton_
        * _showHelpButton_
        * _onHelpButtonPressed_
    * Added `TitleBar` widget _leading_ and _trailing_ parameters

* Fixes
    * Horizontal `RadioOptions` expanded

## 0.2.0
* New
    * `RadioOptions` widget.
    * `Group` widget.
    * `StatusBar` widget. To use on `XpWindow`.

* Fixes
    * `Checkbox` onChanged not working.
    * Remove `TabView` widget fail. [tabbed_view](https://pub.dev/packages/tabbed_view) package recomended.

## 0.1.0
* New
    * `XpWindow` widget. It includes `Siderbar` layout.
    * `SidebarExpandableItem` widget.
    * `ListTile` widget.

* Fixes
    * `XpTheme` color scheme structure.
    * `Checkbox` disabled style.
    * `Checkbox` outline color.
    * `TitleBar` title style.

## 0.0.1

* initial relase.