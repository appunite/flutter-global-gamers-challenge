import 'package:endless_runner/player_progress/entities/challenges_entity.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:endless_runner/player_progress/player_progress_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  group(PlayerProgressController, () {
    late PlayerProgressController playerProgressController;
    late LocalPlayerPersistence localStorage;
    late DatabasePersistence databaseStorage;

    setUp(() async {
      localStorage = MockLocalPlayerPersistence();
      databaseStorage = MockDatabasePersistence();
    });

    test('Initialization sets challenges and nick for empty player', () async {
      when(() => localStorage.getPlayerIdKey()).thenAnswer((_) async => mockedPlayerId);
      when(() => databaseStorage.getPlayerEntity(playerId: mockedPlayerId))
          .thenAnswer((_) async => mockedEmptyPlayerEntity);

      playerProgressController = PlayerProgressController(
        localStorage: localStorage,
        databaseStorage: databaseStorage,
      );

      await pumpEventQueue();

      expect(playerProgressController.challenges, ChallengesEntity.empty());
      expect(playerProgressController.playerNick, mockedEmptyPlayerEntity.nick);
    });

    test('Initialization sets challenges and nick for active player', () async {
      when(() => localStorage.getPlayerIdKey()).thenAnswer((_) async => mockedPlayerId);
      when(() => databaseStorage.getPlayerEntity(playerId: mockedPlayerId))
          .thenAnswer((_) async => mockedPlayerWithChallengesEntity);

      playerProgressController = PlayerProgressController(
        localStorage: localStorage,
        databaseStorage: databaseStorage,
      );

      await pumpEventQueue();

      expect(playerProgressController.challenges, mockedPlayerWithChallengesEntity.challengesScores);
      expect(playerProgressController.playerNick, mockedEmptyPlayerEntity.nick);
    });

    test('Reset invokes databaseStorage.reset and notifies listeners', () async {
      when(() => localStorage.getPlayerIdKey()).thenAnswer((_) async => mockedPlayerId);
      when(() => databaseStorage.getPlayerEntity(playerId: mockedPlayerId))
          .thenAnswer((_) async => mockedPlayerWithChallengesEntity);
      when(() => databaseStorage.reset(playerId: mockedPlayerId)).thenAnswer((_) async => Future.value());

      playerProgressController = PlayerProgressController(
        localStorage: localStorage,
        databaseStorage: databaseStorage,
      );

      await playerProgressController.reset();
      await pumpEventQueue();

      expect(playerProgressController.challenges, ChallengesEntity.empty());
    });
  });
}
