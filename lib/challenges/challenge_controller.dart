import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/challenges/trees_challenge/challenge_summary_entity.dart';
import 'package:better_world/player_progress/entities/player_entity.dart';
import 'package:better_world/player_progress/persistence/database_persistence.dart';
import 'package:better_world/player_progress/persistence/local_player_persistence.dart';
import 'package:flutter/material.dart';

class ChallengeController extends ChangeNotifier {
  ChallengeController({
    required DatabasePersistence databasePersistence,
    required LocalPlayerPersistence localPlayerPersistence,
  })  : _databasePersistence = databasePersistence,
        _localPlayerPersistence = localPlayerPersistence;

  final DatabasePersistence _databasePersistence;
  final LocalPlayerPersistence _localPlayerPersistence;

  /// if the countdown animation before starting should be started
  bool get countDownVisible => _countDownVisible;
  bool _countDownVisible = false;

  /// if the challenge timer should be started
  bool get startChallengeTimer => _startChallengeTimer;
  bool _startChallengeTimer = false;

  /// current score of the challenge
  int get score => _score;
  int _score = 0;

  /// challenge summary data
  ChallengeSummaryEntity? get challengeSummary => _challengeSummary;
  ChallengeSummaryEntity? _challengeSummary;

  void setCountDown({required bool visible}) {
    _countDownVisible = visible;
    notifyListeners();
  }

  void setTimer({required bool shouldStart}) {
    _startChallengeTimer = shouldStart;
    notifyListeners();
  }

  void addPoints({int points = 1}) {
    _score += points;
    notifyListeners();
  }

  void setPoints({required int points}) {
    _score = points;
    notifyListeners();
  }

  Future<void> onChallengeFinished({
    required ChallengeType challengeType,
    int? timeInSec,
  }) async {
    final String playerId = await _localPlayerPersistence.getPlayerIdKey();
    final PlayerEntity playerEntity = await _databasePersistence.getPlayerEntity(playerId: playerId);
    final int? recentChallengeScore = challengeType.getChallengeScore(playerEntity.challengesScores);
    bool shouldDisplayBadge = recentChallengeScore == null && _score > 0;

    late int bestScore;
    if (score > (recentChallengeScore ?? 0)) {
      bestScore = _score;
      await _updateDatabase(challengeType, playerId);
    } else {
      bestScore = recentChallengeScore ?? 0;
    }

    _challengeSummary = ChallengeSummaryEntity(
      challengeType: challengeType,
      score: _score,
      bestScore: bestScore,
      time: timeInSec,
      displayBadge: shouldDisplayBadge,
    );

    notifyListeners();
  }

  Future<void> _updateDatabase(ChallengeType challengeType, String playerId) =>
      _databasePersistence.updateChallengePoints(
        challengeType: challengeType,
        points: _score,
        playerId: playerId,
      );
}
