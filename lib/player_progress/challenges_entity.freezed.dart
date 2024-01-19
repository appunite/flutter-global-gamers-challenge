// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenges_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChallengesEntity _$ChallengesEntityFromJson(Map<String, dynamic> json) {
  return _ChallengesEntity.fromJson(json);
}

/// @nodoc
mixin _$ChallengesEntity {
  int? get city => throw _privateConstructorUsedError;
  int? get ocean => throw _privateConstructorUsedError;
  int? get pipes => throw _privateConstructorUsedError;
  int? get recycling => throw _privateConstructorUsedError;
  int? get solarPanel => throw _privateConstructorUsedError;
  int? get trees => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChallengesEntityCopyWith<ChallengesEntity> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengesEntityCopyWith<$Res> {
  factory $ChallengesEntityCopyWith(ChallengesEntity value, $Res Function(ChallengesEntity) then) =
      _$ChallengesEntityCopyWithImpl<$Res, ChallengesEntity>;
  @useResult
  $Res call({int? city, int? ocean, int? pipes, int? recycling, int? solarPanel, int? trees});
}

/// @nodoc
class _$ChallengesEntityCopyWithImpl<$Res, $Val extends ChallengesEntity> implements $ChallengesEntityCopyWith<$Res> {
  _$ChallengesEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? ocean = freezed,
    Object? pipes = freezed,
    Object? recycling = freezed,
    Object? solarPanel = freezed,
    Object? trees = freezed,
  }) {
    return _then(_value.copyWith(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as int?,
      ocean: freezed == ocean
          ? _value.ocean
          : ocean // ignore: cast_nullable_to_non_nullable
              as int?,
      pipes: freezed == pipes
          ? _value.pipes
          : pipes // ignore: cast_nullable_to_non_nullable
              as int?,
      recycling: freezed == recycling
          ? _value.recycling
          : recycling // ignore: cast_nullable_to_non_nullable
              as int?,
      solarPanel: freezed == solarPanel
          ? _value.solarPanel
          : solarPanel // ignore: cast_nullable_to_non_nullable
              as int?,
      trees: freezed == trees
          ? _value.trees
          : trees // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengesEntityImplCopyWith<$Res> implements $ChallengesEntityCopyWith<$Res> {
  factory _$$ChallengesEntityImplCopyWith(_$ChallengesEntityImpl value, $Res Function(_$ChallengesEntityImpl) then) =
      __$$ChallengesEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? city, int? ocean, int? pipes, int? recycling, int? solarPanel, int? trees});
}

/// @nodoc
class __$$ChallengesEntityImplCopyWithImpl<$Res> extends _$ChallengesEntityCopyWithImpl<$Res, _$ChallengesEntityImpl>
    implements _$$ChallengesEntityImplCopyWith<$Res> {
  __$$ChallengesEntityImplCopyWithImpl(_$ChallengesEntityImpl _value, $Res Function(_$ChallengesEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? ocean = freezed,
    Object? pipes = freezed,
    Object? recycling = freezed,
    Object? solarPanel = freezed,
    Object? trees = freezed,
  }) {
    return _then(_$ChallengesEntityImpl(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as int?,
      ocean: freezed == ocean
          ? _value.ocean
          : ocean // ignore: cast_nullable_to_non_nullable
              as int?,
      pipes: freezed == pipes
          ? _value.pipes
          : pipes // ignore: cast_nullable_to_non_nullable
              as int?,
      recycling: freezed == recycling
          ? _value.recycling
          : recycling // ignore: cast_nullable_to_non_nullable
              as int?,
      solarPanel: freezed == solarPanel
          ? _value.solarPanel
          : solarPanel // ignore: cast_nullable_to_non_nullable
              as int?,
      trees: freezed == trees
          ? _value.trees
          : trees // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengesEntityImpl implements _ChallengesEntity {
  const _$ChallengesEntityImpl({this.city, this.ocean, this.pipes, this.recycling, this.solarPanel, this.trees});

  factory _$ChallengesEntityImpl.fromJson(Map<String, dynamic> json) => _$$ChallengesEntityImplFromJson(json);

  @override
  final int? city;
  @override
  final int? ocean;
  @override
  final int? pipes;
  @override
  final int? recycling;
  @override
  final int? solarPanel;
  @override
  final int? trees;

  @override
  String toString() {
    return 'ChallengesEntity(city: $city, ocean: $ocean, pipes: $pipes, recycling: $recycling, solarPanel: $solarPanel, trees: $trees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengesEntityImpl &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.ocean, ocean) || other.ocean == ocean) &&
            (identical(other.pipes, pipes) || other.pipes == pipes) &&
            (identical(other.recycling, recycling) || other.recycling == recycling) &&
            (identical(other.solarPanel, solarPanel) || other.solarPanel == solarPanel) &&
            (identical(other.trees, trees) || other.trees == trees));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, city, ocean, pipes, recycling, solarPanel, trees);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengesEntityImplCopyWith<_$ChallengesEntityImpl> get copyWith =>
      __$$ChallengesEntityImplCopyWithImpl<_$ChallengesEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengesEntityImplToJson(
      this,
    );
  }
}

abstract class _ChallengesEntity implements ChallengesEntity {
  const factory _ChallengesEntity(
      {final int? city,
      final int? ocean,
      final int? pipes,
      final int? recycling,
      final int? solarPanel,
      final int? trees}) = _$ChallengesEntityImpl;

  factory _ChallengesEntity.fromJson(Map<String, dynamic> json) = _$ChallengesEntityImpl.fromJson;

  @override
  int? get city;
  @override
  int? get ocean;
  @override
  int? get pipes;
  @override
  int? get recycling;
  @override
  int? get solarPanel;
  @override
  int? get trees;
  @override
  @JsonKey(ignore: true)
  _$$ChallengesEntityImplCopyWith<_$ChallengesEntityImpl> get copyWith => throw _privateConstructorUsedError;
}
