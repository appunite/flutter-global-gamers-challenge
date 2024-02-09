import 'package:better_world/challenges/recycling_challenge/garbage_type_enum.dart';
import 'package:flutter/material.dart';

class GarbageController extends ChangeNotifier {
  /// The map of all garbage type and value if it's been sorted
  /// default value for all items (at the beginning of the challange) is false
  Map<GarbageType, bool> get garbageSortedMap => _garbageMap;

  bool get challengeCompleted => _challengeCompleted;

  final Map<GarbageType, bool> _garbageMap = {
    GarbageType.apple: false,
    GarbageType.bag: false,
    GarbageType.banana: false,
    GarbageType.bigWater: false,
    GarbageType.bread: false,
    GarbageType.canOrange: false,
    GarbageType.canPink: false,
    GarbageType.can: false,
    GarbageType.fishbones: false,
    GarbageType.glassBottle: false,
    GarbageType.glassJar: false,
    GarbageType.glass: false,
    GarbageType.metalCan: false,
    GarbageType.packaging: false,
    GarbageType.plasticBox: false,
    GarbageType.paper: false,
    GarbageType.plasticBag: false,
    GarbageType.waterBottle: false,
    GarbageType.watermelon: false,
  };

  bool _challengeCompleted = false;

  void itemSorted(GarbageType garbageType) {
    _garbageMap[garbageType] = true;
    _checkIfChallengeCompleted();
    notifyListeners();
  }

  void _checkIfChallengeCompleted() {
    // if all map values are true, finish the challenge
    final bool allItemsSorted = !_garbageMap.entries.any((entry) => entry.value == false);
    if (allItemsSorted) {
      _challengeCompleted = true;
    }
  }
}
