// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'homework_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HomeworkModel _$HomeworkModelFromJson(Map<String, dynamic> json) {
  return _HomeworkModel.fromJson(json);
}

/// @nodoc
class _$HomeworkModelTearOff {
  const _$HomeworkModelTearOff();

  _HomeworkModel call(
      {int id = 0,
      String beginning_date = '',
      String deadline = '',
      int status = 0,
      String description = ''}) {
    return _HomeworkModel(
      id: id,
      beginning_date: beginning_date,
      deadline: deadline,
      status: status,
      description: description,
    );
  }

  HomeworkModel fromJson(Map<String, Object?> json) {
    return HomeworkModel.fromJson(json);
  }
}

/// @nodoc
const $HomeworkModel = _$HomeworkModelTearOff();

/// @nodoc
mixin _$HomeworkModel {
  int get id => throw _privateConstructorUsedError;
  String get beginning_date => throw _privateConstructorUsedError;
  String get deadline => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeworkModelCopyWith<HomeworkModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeworkModelCopyWith<$Res> {
  factory $HomeworkModelCopyWith(
          HomeworkModel value, $Res Function(HomeworkModel) then) =
      _$HomeworkModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String beginning_date,
      String deadline,
      int status,
      String description});
}

/// @nodoc
class _$HomeworkModelCopyWithImpl<$Res>
    implements $HomeworkModelCopyWith<$Res> {
  _$HomeworkModelCopyWithImpl(this._value, this._then);

  final HomeworkModel _value;
  // ignore: unused_field
  final $Res Function(HomeworkModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? beginning_date = freezed,
    Object? deadline = freezed,
    Object? status = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      beginning_date: beginning_date == freezed
          ? _value.beginning_date
          : beginning_date // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$HomeworkModelCopyWith<$Res>
    implements $HomeworkModelCopyWith<$Res> {
  factory _$HomeworkModelCopyWith(
          _HomeworkModel value, $Res Function(_HomeworkModel) then) =
      __$HomeworkModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String beginning_date,
      String deadline,
      int status,
      String description});
}

/// @nodoc
class __$HomeworkModelCopyWithImpl<$Res>
    extends _$HomeworkModelCopyWithImpl<$Res>
    implements _$HomeworkModelCopyWith<$Res> {
  __$HomeworkModelCopyWithImpl(
      _HomeworkModel _value, $Res Function(_HomeworkModel) _then)
      : super(_value, (v) => _then(v as _HomeworkModel));

  @override
  _HomeworkModel get _value => super._value as _HomeworkModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? beginning_date = freezed,
    Object? deadline = freezed,
    Object? status = freezed,
    Object? description = freezed,
  }) {
    return _then(_HomeworkModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      beginning_date: beginning_date == freezed
          ? _value.beginning_date
          : beginning_date // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HomeworkModel implements _HomeworkModel {
  const _$_HomeworkModel(
      {this.id = 0,
      this.beginning_date = '',
      this.deadline = '',
      this.status = 0,
      this.description = ''});

  factory _$_HomeworkModel.fromJson(Map<String, dynamic> json) =>
      _$$_HomeworkModelFromJson(json);

  @JsonKey()
  @override
  final int id;
  @JsonKey()
  @override
  final String beginning_date;
  @JsonKey()
  @override
  final String deadline;
  @JsonKey()
  @override
  final int status;
  @JsonKey()
  @override
  final String description;

  @override
  String toString() {
    return 'HomeworkModel(id: $id, beginning_date: $beginning_date, deadline: $deadline, status: $status, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeworkModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.beginning_date, beginning_date) &&
            const DeepCollectionEquality().equals(other.deadline, deadline) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(beginning_date),
      const DeepCollectionEquality().hash(deadline),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$HomeworkModelCopyWith<_HomeworkModel> get copyWith =>
      __$HomeworkModelCopyWithImpl<_HomeworkModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HomeworkModelToJson(this);
  }
}

abstract class _HomeworkModel implements HomeworkModel {
  const factory _HomeworkModel(
      {int id,
      String beginning_date,
      String deadline,
      int status,
      String description}) = _$_HomeworkModel;

  factory _HomeworkModel.fromJson(Map<String, dynamic> json) =
      _$_HomeworkModel.fromJson;

  @override
  int get id;
  @override
  String get beginning_date;
  @override
  String get deadline;
  @override
  int get status;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$HomeworkModelCopyWith<_HomeworkModel> get copyWith =>
      throw _privateConstructorUsedError;
}
