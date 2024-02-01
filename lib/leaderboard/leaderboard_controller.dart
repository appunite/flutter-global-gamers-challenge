import 'package:endless_runner/leaderboard/entities/leaderboard_entity.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:flutter/material.dart';

class LeaderboardController {
  LeaderboardController({
    required LocalPlayerPersistence localStorage,
    required DatabasePersistence databaseStorage,
  })  : _localStorage = localStorage,
        _databaseStorage = databaseStorage {
    loadLeaderboardData();
  }

  final LocalPlayerPersistence _localStorage;
  final DatabasePersistence _databaseStorage;

  late ValueNotifier<LeaderboardEntity?> leaderboard = ValueNotifier(null);

  Future<void> loadLeaderboardData() async {
    final playerId = await _localStorage.getPlayerIdKey();
    final players = await _databaseStorage.getLeaderboard();

    leaderboard.value = LeaderboardEntity(
      players: players,
      player: players.firstWhere((player) => player.id == playerId),
    );
  }
}
