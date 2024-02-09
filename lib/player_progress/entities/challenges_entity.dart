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

extension ChallengesEntityExtension on ChallengesEntity {
  int getPlayedChallengesCount() {
    int count = 0;
    if (city != null) {
      count++;
    }
    if (ocean != null) {
      count++;
    }
    if (pipes != null) {
      count++;
    }
    if (recycling != null) {
      count++;
    }
    if (solarPanel != null) {
      count++;
    }
    if (trees != null) {
      count++;
    }

    return count;
  }

  int getAllChallengesScores() {
    return (city ?? 0) + (ocean ?? 0) + (pipes ?? 0) + (recycling ?? 0) + (solarPanel ?? 0) + (trees ?? 0);
  }
}
