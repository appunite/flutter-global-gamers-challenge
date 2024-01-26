// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenges_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengesEntityImpl _$$ChallengesEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$ChallengesEntityImpl(
      city: json['city'] as int?,
      ocean: json['ocean'] as int?,
      pipes: json['pipes'] as int?,
      recycling: json['recycling'] as int?,
      solarPanel: json['solarPanel'] as int?,
      trees: json['trees'] as int?,
    );

Map<String, dynamic> _$$ChallengesEntityImplToJson(
        _$ChallengesEntityImpl instance) =>
    <String, dynamic>{
      'city': instance.city,
      'ocean': instance.ocean,
      'pipes': instance.pipes,
      'recycling': instance.recycling,
      'solarPanel': instance.solarPanel,
      'trees': instance.trees,
    };
