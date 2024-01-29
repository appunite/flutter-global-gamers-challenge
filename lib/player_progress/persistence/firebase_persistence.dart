import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/player_progress/entities/challenges_entity.dart';
import 'package:endless_runner/player_progress/entities/player_entity.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:flutter/widgets.dart';

class FirebasePersistence extends DatabasePersistence {
  FirebasePersistence({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance {
    _playersRef = _firestore.collection(usersCollection);
  }

  late final FirebaseFirestore _firestore;
  late final CollectionReference _playersRef;

  @visibleForTesting
  static const String usersCollection = 'users';

  @override
  Future<PlayerEntity> getPlayerEntity({required String playerId, String? playerNick}) async {
    try {
      final playerDoc = await _playersRef.doc(playerId).get();
      if (playerDoc.exists) {
        return PlayerEntity.fromJson(playerDoc.data() as Map<String, dynamic>);
      } else {
        return _createNewPlayer(playerId: playerId, playerNick: playerNick);
      }
    } catch (e, stack) {
      debugPrintStack(label: e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> updateChallengePoints({
    required ChallengeType challengeType,
    required int points,
    required String playerId,
  }) async {
    try {
      if (points <= 0) {
        return;
      }

      final PlayerEntity playerEntity = await getPlayerEntity(playerId: playerId);

      final ChallengesEntity currentChallenges = playerEntity.challengesScores;
      ChallengesEntity? updatedChallenges;

      switch (challengeType) {
        case ChallengeType.city:
          if (points > (currentChallenges.city ?? 0)) {
            updatedChallenges = currentChallenges.copyWith(city: points);
          }
          break;

        case ChallengeType.ocean:
          if (points > (currentChallenges.ocean ?? 0)) {
            updatedChallenges = currentChallenges.copyWith(ocean: points);
          }
          break;

        case ChallengeType.pipelines:
          if (points > (currentChallenges.pipes ?? 0)) {
            updatedChallenges = currentChallenges.copyWith(pipes: points);
          }
          break;

        case ChallengeType.recycling:
          if (points > (currentChallenges.recycling ?? 0)) {
            updatedChallenges = currentChallenges.copyWith(recycling: points);
          }
          break;

        case ChallengeType.solarPanel:
          if (points > (currentChallenges.solarPanel ?? 0)) {
            updatedChallenges = currentChallenges.copyWith(solarPanel: points);
          }
          break;

        case ChallengeType.trees:
          if (points > (currentChallenges.trees ?? 0)) {
            updatedChallenges = currentChallenges.copyWith(trees: points);
          }
          break;

        default:
          return;
      }

      if (updatedChallenges != null) {
        await _playersRef.doc(playerId).set(
              playerEntity.copyWith(challengesScores: updatedChallenges).toJson(),
            );
      }
    } catch (e, stack) {
      debugPrintStack(label: e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> reset({required String playerId}) async {
    try {
      final playerEntity = await getPlayerEntity(playerId: playerId);
      final updatedPlayer = playerEntity.copyWith(challengesScores: ChallengesEntity.empty());
      await _playersRef.doc(playerId).set(updatedPlayer.toJson());
    } catch (e, stack) {
      debugPrintStack(label: e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<PlayerEntity> _createNewPlayer({required String playerId, String? playerNick}) async {
    late String nick;

    if (playerNick != null) {
      nick = playerNick;
    } else {
      Random random = Random();
      final number = 1000 + random.nextInt(9000);
      nick = 'Eco$number';
    }

    final newPlayer = PlayerEntity.empty(nick: nick);
    await _playersRef.doc(playerId).set(newPlayer.toJson());
    return newPlayer;
  }
}
