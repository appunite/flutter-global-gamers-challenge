import 'package:flutter/material.dart';

class ChallengeStartController extends ChangeNotifier {
  bool get countDownVisible => _countDownVisible;
  bool _countDownVisible = false;

  bool get startChallengeTimer => _startChallengeTimer;
  bool _startChallengeTimer = false;

  void setCountDown({required bool visible}) {
    _countDownVisible = visible;
    notifyListeners();
  }

  void setTimer({required bool shouldStart}) {
    _startChallengeTimer = shouldStart;
    notifyListeners();
  }
}
