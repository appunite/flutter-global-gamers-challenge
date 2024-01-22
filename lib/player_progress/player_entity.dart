import 'package:endless_runner/player_progress/challenges_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_entity.freezed.dart';

part 'player_entity.g.dart';

@freezed
class PlayerEntity with _$PlayerEntity {
  @JsonSerializable(explicitToJson: true)
  const factory PlayerEntity({
    required final ChallengesEntity challengesScores,
    required final String nick,
  }) = _PlayerEntity;

  factory PlayerEntity.empty() => PlayerEntity(
        challengesScores: ChallengesEntity.empty(),
        nick: '', //TODO generate one
      );

  factory PlayerEntity.fromJson(Map<String, dynamic> json) => _$PlayerEntityFromJson(json);
}
