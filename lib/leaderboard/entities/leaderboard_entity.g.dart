// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderboardEntityImpl _$$LeaderboardEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaderboardEntityImpl(
      players: (json['players'] as List<dynamic>)
          .map((e) => PlayerEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      player: PlayerEntity.fromJson(json['player'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LeaderboardEntityImplToJson(
        _$LeaderboardEntityImpl instance) =>
    <String, dynamic>{
      'players': instance.players.map((e) => e.toJson()).toList(),
      'player': instance.player.toJson(),
    };
