import 'package:flutter/material.dart';

class ItemInfoProvider extends ChangeNotifier {
  int _currentIndex = 1;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // void nextIndex() {
  //   _currentIndex++;
  //   print("index $_currentIndex");
  //   notifyListeners();
  // }

  // void previousIndex() {
  //   _currentIndex--;
  //   print("index $_currentIndex");
  //   notifyListeners();
  // }
}
