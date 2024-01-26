import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:flutter/material.dart';

class ChangePlayerNameController {
  ChangePlayerNameController({
    required LocalPlayerPersistence localStorage,
    required DatabasePersistence databaseStorage,
  })  : _localStorage = localStorage,
        _databaseStorage = databaseStorage;

  final LocalPlayerPersistence _localStorage;
  final DatabasePersistence _databaseStorage;

  Future<void> updateUserName({required String username}) async {
    final String playerId = await _localStorage.getPlayerIdKey();
    _databaseStorage.updateUsername(playerId: playerId, username: username);
  }
}
