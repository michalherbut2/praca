import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  int _previousIndex = 0;
  int get previousIndex => _previousIndex;

  void setIndex(int newIndex) {
    _previousIndex = _selectedIndex;
    _selectedIndex = newIndex;
    notifyListeners();
  }
}
