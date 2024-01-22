import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/player_progress/entities/challenges_entity.dart';
import 'package:endless_runner/player_progress/entities/player_entity.dart';
import 'package:endless_runner/player_progress/persistence/firebase_persistence.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';
import 'test_helper.dart';

void main() async {
  late FirebaseFirestore fakeFirestore;
  late FirebasePersistence firebasePersistence;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    firebasePersistence = FirebasePersistence(firestore: fakeFirestore);
  });

  group(FirebasePersistence, () {
    test('get player entity when player exists in Firebase', () async {
      final collection = fakeFirestore.collection(FirebasePersistence.usersCollection);

      // set player in fake firestore
      await expectFirestoreSetCall(
        collection: collection,
        data: mockedPlayerEntity.toJson(),
        docId: mockedPlayerId,
      );

      final result = await firebasePersistence.getPlayerEntity(playerId: mockedPlayerId);

      expect(result, mockedPlayerEntity);
    });

    test('get player entity when user does not exist in Firebase', () async {
      final result = await firebasePersistence.getPlayerEntity(
        playerId: mockedPlayerId,
        playerNick: 'Flutter fan',
      );

      expect(result, mockedEmptyPlayerEntity);
    });

    test('update player challenge score', () async {
      final collection = fakeFirestore.collection(FirebasePersistence.usersCollection);
      const score = 55;
      final updatedChallenges = mockedPlayerEntity.challengesScores.copyWith(ocean: score);
      final updatedPlayer = mockedPlayerEntity.copyWith(challengesScores: updatedChallenges);

      // set player in fake firestore
      await expectFirestoreSetCall(
        collection: collection,
        data: mockedPlayerEntity.toJson(),
        docId: mockedPlayerId,
      );

      await firebasePersistence.updateChallengePoints(
        playerId: mockedPlayerId,
        challengeType: ChallengeType.ocean,
        points: score,
      );

      final result = await collection.doc(mockedPlayerId).get();

      expect(PlayerEntity.fromJson(result.data()!), updatedPlayer);
    });

    test('reset player data', () async {
      final collection = fakeFirestore.collection(FirebasePersistence.usersCollection);
      final currentPlayer = mockedPlayerEntity.copyWith(
        challengesScores: const ChallengesEntity(ocean: 33, pipes: 22, solarPanel: 3),
      );

      // set player in fake firestore
      await expectFirestoreSetCall(
        collection: collection,
        data: currentPlayer.toJson(),
        docId: mockedPlayerId,
      );

      await firebasePersistence.reset(playerId: mockedPlayerId);

      final result = await collection.doc(mockedPlayerId).get();

      expect(PlayerEntity.fromJson(result.data()!), mockedPlayerEntity);
    });
  });
}
