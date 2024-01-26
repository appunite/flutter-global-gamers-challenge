import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/player_progress/entities/player_entity.dart';

abstract class DatabasePersistence {
  Future<PlayerEntity> getPlayerEntity({required String playerId});

  Future<void> updateChallengePoints({
    required ChallengeType challengeType,
    required int points,
    required String playerId,
  });

  Future<void> reset({required String playerId});

  Future<List<PlayerEntity>> getLeaderboard();

  Future<void> updateUsername({required String playerId, required String username});
}
