import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:flutter/foundation.dart';

@immutable
class ChallengeSummaryEntity {
  const ChallengeSummaryEntity({
    required this.challengeType,
    required this.score,
    required this.bestScore,
    this.time,
    required this.displayBadge,
  });

  final ChallengeType challengeType;
  final int score;
  final int bestScore;
  final int? time;
  final bool displayBadge;
}
