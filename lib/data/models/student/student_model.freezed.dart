// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'student_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) {
  return _StudentModel.fromJson(json);
}

/// @nodoc
class _$StudentModelTearOff {
  const _$StudentModelTearOff();

  _StudentModel call(
      {int id = 0,
      String fio = '',
      int status = 0,
      String cur_living_description = '',
      String cur_living_address = ''}) {
    return _StudentModel(
      id: id,
      fio: fio,
      status: status,
      cur_living_description: cur_living_description,
      cur_living_address: cur_living_address,
    );
  }

  StudentModel fromJson(Map<String, Object?> json) {
    return StudentModel.fromJson(json);
  }
}

/// @nodoc
const $StudentModel = _$StudentModelTearOff();

/// @nodoc
mixin _$StudentModel {
  int get id => throw _privateConstructorUsedError;
  String get fio => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  String get cur_living_description => throw _privateConstructorUsedError;
  String get cur_living_address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudentModelCopyWith<StudentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentModelCopyWith<$Res> {
  factory $StudentModelCopyWith(
          StudentModel value, $Res Function(StudentModel) then) =
      _$StudentModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String fio,
      int status,
      String cur_living_description,
      String cur_living_address});
}

/// @nodoc
class _$StudentModelCopyWithImpl<$Res> implements $StudentModelCopyWith<$Res> {
  _$StudentModelCopyWithImpl(this._value, this._then);

  final StudentModel _value;
  // ignore: unused_field
  final $Res Function(StudentModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? fio = freezed,
    Object? status = freezed,
    Object? cur_living_description = freezed,
    Object? cur_living_address = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fio: fio == freezed
          ? _value.fio
          : fio // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      cur_living_description: cur_living_description == freezed
          ? _value.cur_living_description
          : cur_living_description // ignore: cast_nullable_to_non_nullable
              as String,
      cur_living_address: cur_living_address == freezed
          ? _value.cur_living_address
          : cur_living_address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$StudentModelCopyWith<$Res>
    implements $StudentModelCopyWith<$Res> {
  factory _$StudentModelCopyWith(
          _StudentModel value, $Res Function(_StudentModel) then) =
      __$StudentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String fio,
      int status,
      String cur_living_description,
      String cur_living_address});
}

/// @nodoc
class __$StudentModelCopyWithImpl<$Res> extends _$StudentModelCopyWithImpl<$Res>
    implements _$StudentModelCopyWith<$Res> {
  __$StudentModelCopyWithImpl(
      _StudentModel _value, $Res Function(_StudentModel) _then)
      : super(_value, (v) => _then(v as _StudentModel));

  @override
  _StudentModel get _value => super._value as _StudentModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? fio = freezed,
    Object? status = freezed,
    Object? cur_living_description = freezed,
    Object? cur_living_address = freezed,
  }) {
    return _then(_StudentModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fio: fio == freezed
          ? _value.fio
          : fio // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      cur_living_description: cur_living_description == freezed
          ? _value.cur_living_description
          : cur_living_description // ignore: cast_nullable_to_non_nullable
              as String,
      cur_living_address: cur_living_address == freezed
          ? _value.cur_living_address
          : cur_living_address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StudentModel implements _StudentModel {
  const _$_StudentModel(
      {this.id = 0,
      this.fio = '',
      this.status = 0,
      this.cur_living_description = '',
      this.cur_living_address = ''});

  factory _$_StudentModel.fromJson(Map<String, dynamic> json) =>
      _$$_StudentModelFromJson(json);

  @JsonKey()
  @override
  final int id;
  @JsonKey()
  @override
  final String fio;
  @JsonKey()
  @override
  final int status;
  @JsonKey()
  @override
  final String cur_living_description;
  @JsonKey()
  @override
  final String cur_living_address;

  @override
  String toString() {
    return 'StudentModel(id: $id, fio: $fio, status: $status, cur_living_description: $cur_living_description, cur_living_address: $cur_living_address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StudentModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.fio, fio) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.cur_living_description, cur_living_description) &&
            const DeepCollectionEquality()
                .equals(other.cur_living_address, cur_living_address));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(fio),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(cur_living_description),
      const DeepCollectionEquality().hash(cur_living_address));

  @JsonKey(ignore: true)
  @override
  _$StudentModelCopyWith<_StudentModel> get copyWith =>
      __$StudentModelCopyWithImpl<_StudentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StudentModelToJson(this);
  }
}

abstract class _StudentModel implements StudentModel {
  const factory _StudentModel(
      {int id,
      String fio,
      int status,
      String cur_living_description,
      String cur_living_address}) = _$_StudentModel;

  factory _StudentModel.fromJson(Map<String, dynamic> json) =
      _$_StudentModel.fromJson;

  @override
  int get id;
  @override
  String get fio;
  @override
  int get status;
  @override
  String get cur_living_description;
  @override
  String get cur_living_address;
  @override
  @JsonKey(ignore: true)
  _$StudentModelCopyWith<_StudentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
