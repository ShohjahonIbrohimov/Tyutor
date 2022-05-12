// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'groups_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupsModel _$GroupsModelFromJson(Map<String, dynamic> json) {
  return _GroupsModel.fromJson(json);
}

/// @nodoc
class _$GroupsModelTearOff {
  const _$GroupsModelTearOff();

  _GroupsModel call(
      {int id = 0, String name = 'No group name', int studentCount = 0}) {
    return _GroupsModel(
      id: id,
      name: name,
      studentCount: studentCount,
    );
  }

  GroupsModel fromJson(Map<String, Object?> json) {
    return GroupsModel.fromJson(json);
  }
}

/// @nodoc
const $GroupsModel = _$GroupsModelTearOff();

/// @nodoc
mixin _$GroupsModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get studentCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupsModelCopyWith<GroupsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupsModelCopyWith<$Res> {
  factory $GroupsModelCopyWith(
          GroupsModel value, $Res Function(GroupsModel) then) =
      _$GroupsModelCopyWithImpl<$Res>;
  $Res call({int id, String name, int studentCount});
}

/// @nodoc
class _$GroupsModelCopyWithImpl<$Res> implements $GroupsModelCopyWith<$Res> {
  _$GroupsModelCopyWithImpl(this._value, this._then);

  final GroupsModel _value;
  // ignore: unused_field
  final $Res Function(GroupsModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? studentCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      studentCount: studentCount == freezed
          ? _value.studentCount
          : studentCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$GroupsModelCopyWith<$Res>
    implements $GroupsModelCopyWith<$Res> {
  factory _$GroupsModelCopyWith(
          _GroupsModel value, $Res Function(_GroupsModel) then) =
      __$GroupsModelCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, int studentCount});
}

/// @nodoc
class __$GroupsModelCopyWithImpl<$Res> extends _$GroupsModelCopyWithImpl<$Res>
    implements _$GroupsModelCopyWith<$Res> {
  __$GroupsModelCopyWithImpl(
      _GroupsModel _value, $Res Function(_GroupsModel) _then)
      : super(_value, (v) => _then(v as _GroupsModel));

  @override
  _GroupsModel get _value => super._value as _GroupsModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? studentCount = freezed,
  }) {
    return _then(_GroupsModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      studentCount: studentCount == freezed
          ? _value.studentCount
          : studentCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupsModel implements _GroupsModel {
  const _$_GroupsModel(
      {this.id = 0, this.name = 'No group name', this.studentCount = 0});

  factory _$_GroupsModel.fromJson(Map<String, dynamic> json) =>
      _$$_GroupsModelFromJson(json);

  @JsonKey()
  @override
  final int id;
  @JsonKey()
  @override
  final String name;
  @JsonKey()
  @override
  final int studentCount;

  @override
  String toString() {
    return 'GroupsModel(id: $id, name: $name, studentCount: $studentCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GroupsModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.studentCount, studentCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(studentCount));

  @JsonKey(ignore: true)
  @override
  _$GroupsModelCopyWith<_GroupsModel> get copyWith =>
      __$GroupsModelCopyWithImpl<_GroupsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupsModelToJson(this);
  }
}

abstract class _GroupsModel implements GroupsModel {
  const factory _GroupsModel({int id, String name, int studentCount}) =
      _$_GroupsModel;

  factory _GroupsModel.fromJson(Map<String, dynamic> json) =
      _$_GroupsModel.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int get studentCount;
  @override
  @JsonKey(ignore: true)
  _$GroupsModelCopyWith<_GroupsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
