import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_entity.freezed.dart';

part 'player_entity.g.dart';

@freezed
class PlayerEntity with _$PlayerEntity {
  const PlayerEntity._();

  @JsonSerializable(explicitToJson: true)
  const factory PlayerEntity({
    required final ChallengesEntity challengesScores,
    required final String nick,
    required final String id,
  }) = _PlayerEntity;

  factory PlayerEntity.empty({
    required String nick,
    required String id,
  }) =>
      PlayerEntity(
        challengesScores: ChallengesEntity.empty(),
        nick: nick,
        id: id,
      );

  factory PlayerEntity.fromJson(Map<String, dynamic> json) => _$PlayerEntityFromJson(json);
}
