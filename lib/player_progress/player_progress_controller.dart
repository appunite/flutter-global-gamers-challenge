import 'dart:async';

import 'package:endless_runner/player_progress/entities/challenges_entity.dart';
import 'package:endless_runner/player_progress/entities/player_entity.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:flutter/material.dart';

class PlayerProgressController extends ChangeNotifier {
  PlayerProgressController({
    required LocalPlayerPersistence localStorage,
    required DatabasePersistence databaseStorage,
  })  : _localStorage = localStorage,
        _databaseStorage = databaseStorage {
    _loadPlayerData();
  }

  final LocalPlayerPersistence _localStorage;
  final DatabasePersistence _databaseStorage;

  ChallengesEntity _challenges = ChallengesEntity.empty();
  ChallengesEntity get challenges => _challenges;

  String _playerNick = '';
  String get playerNick => _playerNick;

  bool _hasSeenOnboarding = true;
  bool get hasSeenOnboarding => _hasSeenOnboarding;

  Future<void> _loadPlayerData() async {
    final String playerId = await _localStorage.getPlayerIdKey();
    final PlayerEntity playerEntity = await _databaseStorage.getPlayerEntity(playerId: playerId);
    final bool hasSeenOnboarding = await _localStorage.getHasSeenOnboarding();

    _challenges = playerEntity.challengesScores;
    _playerNick = playerEntity.nick;
    _hasSeenOnboarding = hasSeenOnboarding;
    notifyListeners();
  }

  Future<void> reset() async {
    final String playerId = await _localStorage.getPlayerIdKey();
    await _databaseStorage.reset(playerId: playerId);
    _challenges = ChallengesEntity.empty();
    notifyListeners();
  }

  Future<void> setHasSeenOnboarding() async {
    await _localStorage.setHasSeenOnboarding();
    _hasSeenOnboarding = true;
    notifyListeners();
  }
}
