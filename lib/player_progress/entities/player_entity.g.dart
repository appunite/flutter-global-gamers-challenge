// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerEntityImpl _$$PlayerEntityImplFromJson(Map<String, dynamic> json) =>
    _$PlayerEntityImpl(
      challengesScores: ChallengesEntity.fromJson(
          json['challengesScores'] as Map<String, dynamic>),
      nick: json['nick'] as String,
    );

Map<String, dynamic> _$$PlayerEntityImplToJson(_$PlayerEntityImpl instance) =>
    <String, dynamic>{
      'challengesScores': instance.challengesScores.toJson(),
      'nick': instance.nick,
    };
