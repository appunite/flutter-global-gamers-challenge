import 'package:endless_runner/player_progress/entities/player_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_entity.freezed.dart';
part 'leaderboard_entity.g.dart';

@freezed
class LeaderboardEntity with _$LeaderboardEntity {
  @JsonSerializable(explicitToJson: true)
  const factory LeaderboardEntity({
    required final List<PlayerEntity> players,
    required final PlayerEntity player,
  }) = _LeaderboardEntity;

  factory LeaderboardEntity.fromJson(Map<String, dynamic> json) => _$LeaderboardEntityFromJson(json);
}
