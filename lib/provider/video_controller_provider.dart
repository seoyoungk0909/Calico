import 'package:flutter/material.dart';

class VideoControllerProvider extends ChangeNotifier {
  bool _videoReady = false;

  bool get videoReady => _videoReady;

  set videoReady(bool value) {
    _videoReady = value;
    notifyListeners();
  }
}
