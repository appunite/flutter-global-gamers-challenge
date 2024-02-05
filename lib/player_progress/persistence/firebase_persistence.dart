import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/player_progress/entities/challenges_entity.dart';
import 'package:endless_runner/player_progress/entities/player_entity.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:flutter/widgets.dart';

class FirebasePersistence extends DatabasePersistence {
  FirebasePersistence({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _playersRef = _firestore.collection(usersCollection);
  }

  late final FirebaseFirestore _firestore;
  late final CollectionReference _playersRef;

  @visibleForTesting
  static const String usersCollection = 'users';

  @override
  Future<PlayerEntity> getPlayerEntity({
    required String playerId,
    String? playerNick,
  }) async {
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

      final updatedChallenges = switch (challengeType) {
        ChallengeType.city => currentChallenges.copyWith(city: points),
        ChallengeType.ocean => currentChallenges.copyWith(ocean: points),
        ChallengeType.pipelines => currentChallenges.copyWith(pipes: points),
        ChallengeType.recycling => currentChallenges.copyWith(recycling: points),
        ChallengeType.solarPanel => currentChallenges.copyWith(solarPanel: points),
        ChallengeType.trees => currentChallenges.copyWith(trees: points),
      };

      await _playersRef.doc(playerId).set(
            playerEntity.copyWith(challengesScores: updatedChallenges).toJson(),
          );
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

  Future<PlayerEntity> _createNewPlayer({
    required String playerId,
    String? playerNick,
  }) async {
    late String nick;

    if (playerNick != null) {
      nick = playerNick;
    } else {
      Random random = Random();
      final number = 1000 + random.nextInt(9000);
      nick = 'Eco$number';
    }

    final newPlayer = PlayerEntity.empty(nick: nick, id: playerId);
    await _playersRef.doc(playerId).set(newPlayer.toJson());
    return newPlayer;
  }

  @override
  Future<List<PlayerEntity>> getLeaderboard() async {
    try {
      final QuerySnapshot querySnapshot = await _playersRef.get();
      final List<PlayerEntity> players = querySnapshot.docs.map((doc) {
        return PlayerEntity.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      players.sort(
        (a, b) => b.challengesScores.getAllChallengesScores().compareTo(
              a.challengesScores.getAllChallengesScores(),
            ),
      );

      return players;
    } catch (e, stack) {
      debugPrintStack(label: e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> updateUsername({
    required String playerId,
    required String username,
  }) async {
    try {
      final playerDoc = await _playersRef.doc(playerId).get();
      if (playerDoc.exists) {
        await _playersRef.doc(playerId).update({
          'nick': username,
        });
      }
    } catch (e, stack) {
      debugPrintStack(label: e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
