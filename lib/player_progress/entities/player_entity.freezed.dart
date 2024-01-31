// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlayerEntity _$PlayerEntityFromJson(Map<String, dynamic> json) {
  return _PlayerEntity.fromJson(json);
}

/// @nodoc
mixin _$PlayerEntity {
  ChallengesEntity get challengesScores => throw _privateConstructorUsedError;
  String get nick => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerEntityCopyWith<PlayerEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerEntityCopyWith<$Res> {
  factory $PlayerEntityCopyWith(
          PlayerEntity value, $Res Function(PlayerEntity) then) =
      _$PlayerEntityCopyWithImpl<$Res, PlayerEntity>;
  @useResult
  $Res call({ChallengesEntity challengesScores, String nick, String id});

  $ChallengesEntityCopyWith<$Res> get challengesScores;
}

/// @nodoc
class _$PlayerEntityCopyWithImpl<$Res, $Val extends PlayerEntity>
    implements $PlayerEntityCopyWith<$Res> {
  _$PlayerEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengesScores = null,
    Object? nick = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      challengesScores: null == challengesScores
          ? _value.challengesScores
          : challengesScores // ignore: cast_nullable_to_non_nullable
              as ChallengesEntity,
      nick: null == nick
          ? _value.nick
          : nick // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChallengesEntityCopyWith<$Res> get challengesScores {
    return $ChallengesEntityCopyWith<$Res>(_value.challengesScores, (value) {
      return _then(_value.copyWith(challengesScores: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerEntityImplCopyWith<$Res>
    implements $PlayerEntityCopyWith<$Res> {
  factory _$$PlayerEntityImplCopyWith(
          _$PlayerEntityImpl value, $Res Function(_$PlayerEntityImpl) then) =
      __$$PlayerEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChallengesEntity challengesScores, String nick, String id});

  @override
  $ChallengesEntityCopyWith<$Res> get challengesScores;
}

/// @nodoc
class __$$PlayerEntityImplCopyWithImpl<$Res>
    extends _$PlayerEntityCopyWithImpl<$Res, _$PlayerEntityImpl>
    implements _$$PlayerEntityImplCopyWith<$Res> {
  __$$PlayerEntityImplCopyWithImpl(
      _$PlayerEntityImpl _value, $Res Function(_$PlayerEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengesScores = null,
    Object? nick = null,
    Object? id = null,
  }) {
    return _then(_$PlayerEntityImpl(
      challengesScores: null == challengesScores
          ? _value.challengesScores
          : challengesScores // ignore: cast_nullable_to_non_nullable
              as ChallengesEntity,
      nick: null == nick
          ? _value.nick
          : nick // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PlayerEntityImpl extends _PlayerEntity {
  const _$PlayerEntityImpl(
      {required this.challengesScores, required this.nick, required this.id})
      : super._();

  factory _$PlayerEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerEntityImplFromJson(json);

  @override
  final ChallengesEntity challengesScores;
  @override
  final String nick;
  @override
  final String id;

  @override
  String toString() {
    return 'PlayerEntity(challengesScores: $challengesScores, nick: $nick, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerEntityImpl &&
            (identical(other.challengesScores, challengesScores) ||
                other.challengesScores == challengesScores) &&
            (identical(other.nick, nick) || other.nick == nick) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, challengesScores, nick, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerEntityImplCopyWith<_$PlayerEntityImpl> get copyWith =>
      __$$PlayerEntityImplCopyWithImpl<_$PlayerEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerEntityImplToJson(
      this,
    );
  }
}

abstract class _PlayerEntity extends PlayerEntity {
  const factory _PlayerEntity(
      {required final ChallengesEntity challengesScores,
      required final String nick,
      required final String id}) = _$PlayerEntityImpl;
  const _PlayerEntity._() : super._();

  factory _PlayerEntity.fromJson(Map<String, dynamic> json) =
      _$PlayerEntityImpl.fromJson;

  @override
  ChallengesEntity get challengesScores;
  @override
  String get nick;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$PlayerEntityImplCopyWith<_$PlayerEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
