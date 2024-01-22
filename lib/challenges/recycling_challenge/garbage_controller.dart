import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/recycling_challenge/garbage_type_enum.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/firebase_persistence.dart';
import 'package:flutter/material.dart';

class GarbageController extends ChangeNotifier {
  GarbageController({DatabasePersistence? store}) : _store = store ?? FirebasePersistence();

  final DatabasePersistence _store;

  /// The map of all garbage type and value if it's been sorted
  /// default value for all items (at the beginning of the challange) is false
  Map<GarbageType, bool> get garbageSortedMap => _garbageMap;

  bool get challengeCompleted => _challengeCompleted;

  final Map<GarbageType, bool> _garbageMap = {
    GarbageType.apple: false,
    GarbageType.banana: false,
    GarbageType.can: false,
    GarbageType.cardboard: false,
    GarbageType.diaper: false,
    GarbageType.documents: false,
    GarbageType.fishbones: false,
    GarbageType.glassBottle: false,
    GarbageType.lightbulb: false,
    GarbageType.plasticBottle: false,
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
      _store.updateChallengePoints(
        challengeType: ChallengeType.recycling,
        points: 10, //TODO
        playerId: 'fM0gJICRwZMu9a9sTzUX', //TODO
      );
      _challengeCompleted = true;
    }
  }
}
