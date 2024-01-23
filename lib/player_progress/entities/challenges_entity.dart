import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenges_entity.freezed.dart';

part 'challenges_entity.g.dart';

@freezed
class ChallengesEntity with _$ChallengesEntity {
  const factory ChallengesEntity({
    final int? city,
    final int? ocean,
    final int? pipes,
    final int? recycling,
    final int? solarPanel,
    final int? trees,
  }) = _ChallengesEntity;

  factory ChallengesEntity.empty() => const ChallengesEntity();

  factory ChallengesEntity.fromJson(Map<String, dynamic> json) => _$ChallengesEntityFromJson(json);
}
