import 'package:flutter/widgets.dart';

typedef OnIndexChanged = void Function(int index);

class XpTabViewController extends ChangeNotifier {
  XpTabViewController({required this.length, int initialIndex = 0})
      : _selectedIndex = initialIndex,
        _previousIndex = initialIndex;
  final int length;

  int _selectedIndex;
  int get selectedIndex => _selectedIndex;

  /// Changes the index of the selection and notifies.
  set selectedIndex(int tabIndex) {
    _validateIndex(tabIndex);
  }

  void _validateIndex(int tabIndex) {
    assert(tabIndex >= 0 && (tabIndex < length || length == 0));
    if (tabIndex == _selectedIndex || length < 2) {
      return;
    }
    _previousIndex = selectedIndex;
    _selectedIndex = tabIndex;
    notifyListeners();
  }

  /// The index of the previously selected tab.
  ///
  /// Initially the same as index.`
  int get previousIndex => _previousIndex;
  int _previousIndex;
}

mixin TabIndex {
  int _index = -1;

  int get index => _index;

  void _setIndex(int newIndex) {
    _index = newIndex;
  }
}
