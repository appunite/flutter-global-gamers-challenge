import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/trees_challenge/challenge_summary_entity.dart';
import 'package:endless_runner/player_progress/entities/player_entity.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:flutter/material.dart';

class TreesChallengeController extends ChangeNotifier {
  TreesChallengeController({
    required DatabasePersistence databasePersistence,
    required LocalPlayerPersistence localPlayerPersistence,
    required int startingTimeInSeconds,
  })  : _databasePersistence = databasePersistence,
        _localPlayerPersistence = localPlayerPersistence,
        _challengeTime = startingTimeInSeconds;

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

  /// current time on the timer (in seconds)
  int get challengeTime => _challengeTime;
  int _challengeTime;

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

  void updateTime({bool countDown = false}) {
    if (countDown) {
      _challengeTime--;
    } else {
      _challengeTime++;
    }
    notifyListeners();
  }

  void addPoints({int points = 1}) {
    _score += points;
    notifyListeners();
  }

  Future<void> onFinish({
    required ChallengeType challengeType,
  }) async {
    final String playerId = await _localPlayerPersistence.getPlayerIdKey();
    final PlayerEntity playerEntity = await _databasePersistence.getPlayerEntity(playerId: playerId);
    final int? recentChallengeScore = challengeType.getChallengeScore(playerEntity.challengesScores);
    bool shouldDisplayBadge = recentChallengeScore == null && _score > 0;

    late int bestScore;
    if (score > (recentChallengeScore ?? 0)) {
      bestScore = _score;
    } else {
      bestScore = recentChallengeScore ?? 0;
    }

    _challengeSummary = ChallengeSummaryEntity(
      challengeType: challengeType,
      score: _score,
      bestScore: bestScore,
      time: _challengeTime,
      displayBadge: shouldDisplayBadge,
    );

    if (_score > 0) {
      await _updateDatabase(challengeType, playerId);
    }
    notifyListeners();
  }

  Future<void> _updateDatabase(ChallengeType challengeType, String playerId) async {
    await _databasePersistence.updateChallengePoints(
      challengeType: challengeType,
      points: _score,
      playerId: playerId,
    );
  }
}
