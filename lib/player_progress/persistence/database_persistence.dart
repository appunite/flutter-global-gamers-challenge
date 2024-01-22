import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/player_progress/player_entity.dart';

abstract class DatabasePersistence {
  Future<PlayerEntity> getPlayerEntity({required String playerId});

  Future<void> updateChallengePoints({
    required ChallengeType challengeType,
    required int points,
    required String playerId,
  });

  Future<void> reset({required String playerId});
}