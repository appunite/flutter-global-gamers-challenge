import 'package:flutter/material.dart';
import 'dart:math' as math;

class PipesController extends ChangeNotifier {
  static const double _pi = math.pi;

  /// The list of all pipes rotation angles in the grid
  /// The values are multiples of 90 degrees (pi/2)
  List<List<double>> get pipesCurrentAngles => _currentAngles;

  final List<List<double>> _currentAngles = [
    [0.0, 0.0, 0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0, 0.0, 0.0],
  ];

  final List<List<double>> _correctAngles = [
    [_pi / 2, _pi / 2, _pi / 2, _pi / 2, _pi / 2],
    [_pi / 2, _pi / 2, _pi / 2, _pi / 2, _pi / 2],
    [_pi / 2, _pi / 2, _pi / 2, _pi / 2, _pi / 2],
  ];

  bool get challengeCompleted => _challengeCompleted;

  bool _challengeCompleted = false;

  void itemTurned({
    required int row,
    required int column,
  }) {
    _currentAngles[row][column] += _pi / 2;
    if (_currentAngles[row][column] >= 2 * _pi) {
      _currentAngles[row][column] = 0.0;
    }
    _checkIfChallengeCompleted();
    notifyListeners();
  }

  void _checkIfChallengeCompleted() {
    final bool allPipesInRightAngle = areMatricesEqual();
    if (allPipesInRightAngle) {
      _challengeCompleted = true;
    }
  }

  bool areMatricesEqual() {
    if (_currentAngles.length != _correctAngles.length || _currentAngles.isEmpty) {
      return false;
    }

    for (int i = 0; i < _currentAngles.length; i++) {
      if (_currentAngles[i].length != _correctAngles[i].length) {
        return false;
      }

      for (int j = 0; j < _currentAngles[i].length; j++) {
        if (_currentAngles[i][j] != _correctAngles[i][j]) {
          return false;
        }
      }
    }

    return true;
  }
}
