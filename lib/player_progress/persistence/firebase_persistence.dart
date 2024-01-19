import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/player_progress/challenges_entity.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/player_entity.dart';
import 'package:flutter/widgets.dart';

class FirebasePersistence extends DatabasePersistence {
  FirebasePersistence() {
    _playersRef = db.collection(usersCollection);
  }

  late final FirebaseFirestore db = FirebaseFirestore.instance;
  late final CollectionReference _playersRef;

  @visibleForTesting
  static const String usersCollection = 'users';

  @override
  Future<PlayerEntity> getPlayerEntity({required String playerId}) async {
    try {
      final playerDoc = await _playersRef.doc(playerId).get();
      if (playerDoc.exists) {
        return PlayerEntity.fromJson(playerDoc.data() as Map<String, dynamic>);
      } else {
        return _createNewPlayer(playerId);
      }
    } catch (e, stack) {
      debugPrintStack(label: e.toString(), stackTrace: stack);
      throw Exception('TODO'); //TODO
    }
  }

  @override
  Future<void> updateChallengePoints({
    required ChallengeType challengeType,
    required int points,
    required String playerId,
  }) async {
    try {
      final PlayerEntity playerEntity = await getPlayerEntity(playerId: playerId);

      final ChallengesEntity currentChallenges = playerEntity.challengesScores;
      final updatedChallenges = switch (challengeType) {
        ChallengeType.city => currentChallenges.copyWith(city: points),
        ChallengeType.ocean => currentChallenges.copyWith(ocean: points),
        ChallengeType.pipes => currentChallenges.copyWith(pipes: points),
        ChallengeType.recycling => currentChallenges.copyWith(recycling: points),
        ChallengeType.solarPanel => currentChallenges.copyWith(solarPanel: points),
        ChallengeType.trees => currentChallenges.copyWith(trees: points)
      };

      await _playersRef.doc(playerId).set(
            playerEntity.copyWith(challengesScores: updatedChallenges).toJson(),
          );
    } catch (e, stack) {
      debugPrintStack(label: e.toString(), stackTrace: stack);
      throw Exception('TODO'); //TODO
    }
  }

  @override
  Future<void> reset({required String playerId}) => _playersRef.doc(playerId).delete();

  Future<PlayerEntity> _createNewPlayer(String playerId) async {
    final newPlayer = PlayerEntity.empty();
    await _playersRef.doc(playerId).set(newPlayer.toJson());
    return newPlayer;
  }
}
