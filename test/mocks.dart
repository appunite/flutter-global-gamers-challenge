import 'package:endless_runner/player_progress/entities/challenges_entity.dart';
import 'package:endless_runner/player_progress/entities/player_entity.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalPlayerPersistence extends Mock implements LocalPlayerPersistence {}

class MockDatabasePersistence extends Mock implements DatabasePersistence {}

const mockedPlayerId = 's2f11Jk33242addfsdSDF';

final mockedEmptyPlayerEntity = PlayerEntity.empty(
  nick: 'Flutter fan',
);
final mockedPlayerEntity = PlayerEntity(
  challengesScores: ChallengesEntity.empty(),
  nick: 'Flutter fan',
);
