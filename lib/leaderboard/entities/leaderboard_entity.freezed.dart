// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LeaderboardEntity _$LeaderboardEntityFromJson(Map<String, dynamic> json) {
  return _LeaderboardEntity.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardEntity {
  List<PlayerEntity> get players => throw _privateConstructorUsedError;
  PlayerEntity get player => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaderboardEntityCopyWith<LeaderboardEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardEntityCopyWith<$Res> {
  factory $LeaderboardEntityCopyWith(
          LeaderboardEntity value, $Res Function(LeaderboardEntity) then) =
      _$LeaderboardEntityCopyWithImpl<$Res, LeaderboardEntity>;
  @useResult
  $Res call({List<PlayerEntity> players, PlayerEntity player});

  $PlayerEntityCopyWith<$Res> get player;
}

/// @nodoc
class _$LeaderboardEntityCopyWithImpl<$Res, $Val extends LeaderboardEntity>
    implements $LeaderboardEntityCopyWith<$Res> {
  _$LeaderboardEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? players = null,
    Object? player = null,
  }) {
    return _then(_value.copyWith(
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerEntity>,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PlayerEntity,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerEntityCopyWith<$Res> get player {
    return $PlayerEntityCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LeaderboardEntityImplCopyWith<$Res>
    implements $LeaderboardEntityCopyWith<$Res> {
  factory _$$LeaderboardEntityImplCopyWith(_$LeaderboardEntityImpl value,
          $Res Function(_$LeaderboardEntityImpl) then) =
      __$$LeaderboardEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PlayerEntity> players, PlayerEntity player});

  @override
  $PlayerEntityCopyWith<$Res> get player;
}

/// @nodoc
class __$$LeaderboardEntityImplCopyWithImpl<$Res>
    extends _$LeaderboardEntityCopyWithImpl<$Res, _$LeaderboardEntityImpl>
    implements _$$LeaderboardEntityImplCopyWith<$Res> {
  __$$LeaderboardEntityImplCopyWithImpl(_$LeaderboardEntityImpl _value,
      $Res Function(_$LeaderboardEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? players = null,
    Object? player = null,
  }) {
    return _then(_$LeaderboardEntityImpl(
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerEntity>,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PlayerEntity,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$LeaderboardEntityImpl implements _LeaderboardEntity {
  const _$LeaderboardEntityImpl(
      {required final List<PlayerEntity> players, required this.player})
      : _players = players;

  factory _$LeaderboardEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardEntityImplFromJson(json);

  final List<PlayerEntity> _players;
  @override
  List<PlayerEntity> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  final PlayerEntity player;

  @override
  String toString() {
    return 'LeaderboardEntity(players: $players, player: $player)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardEntityImpl &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.player, player) || other.player == player));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_players), player);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardEntityImplCopyWith<_$LeaderboardEntityImpl> get copyWith =>
      __$$LeaderboardEntityImplCopyWithImpl<_$LeaderboardEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardEntityImplToJson(
      this,
    );
  }
}

abstract class _LeaderboardEntity implements LeaderboardEntity {
  const factory _LeaderboardEntity(
      {required final List<PlayerEntity> players,
      required final PlayerEntity player}) = _$LeaderboardEntityImpl;

  factory _LeaderboardEntity.fromJson(Map<String, dynamic> json) =
      _$LeaderboardEntityImpl.fromJson;

  @override
  List<PlayerEntity> get players;
  @override
  PlayerEntity get player;
  @override
  @JsonKey(ignore: true)
  _$$LeaderboardEntityImplCopyWith<_$LeaderboardEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
