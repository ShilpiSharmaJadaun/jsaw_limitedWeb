// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userwise_table_export.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserWiseTableExport _$UserWiseTableExportFromJson(Map<String, dynamic> json) {
  return _UserWiseTableExport.fromJson(json);
}

/// @nodoc
mixin _$UserWiseTableExport {
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserWiseTableExportCopyWith<UserWiseTableExport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserWiseTableExportCopyWith<$Res> {
  factory $UserWiseTableExportCopyWith(
          UserWiseTableExport value, $Res Function(UserWiseTableExport) then) =
      _$UserWiseTableExportCopyWithImpl<$Res, UserWiseTableExport>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$UserWiseTableExportCopyWithImpl<$Res, $Val extends UserWiseTableExport>
    implements $UserWiseTableExportCopyWith<$Res> {
  _$UserWiseTableExportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserWiseTableExportImplCopyWith<$Res>
    implements $UserWiseTableExportCopyWith<$Res> {
  factory _$$UserWiseTableExportImplCopyWith(_$UserWiseTableExportImpl value,
          $Res Function(_$UserWiseTableExportImpl) then) =
      __$$UserWiseTableExportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$UserWiseTableExportImplCopyWithImpl<$Res>
    extends _$UserWiseTableExportCopyWithImpl<$Res, _$UserWiseTableExportImpl>
    implements _$$UserWiseTableExportImplCopyWith<$Res> {
  __$$UserWiseTableExportImplCopyWithImpl(_$UserWiseTableExportImpl _value,
      $Res Function(_$UserWiseTableExportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$UserWiseTableExportImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserWiseTableExportImpl implements _UserWiseTableExport {
  const _$UserWiseTableExportImpl({this.url = ""});

  factory _$UserWiseTableExportImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserWiseTableExportImplFromJson(json);

  @override
  @JsonKey()
  final String url;

  @override
  String toString() {
    return 'UserWiseTableExport(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserWiseTableExportImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserWiseTableExportImplCopyWith<_$UserWiseTableExportImpl> get copyWith =>
      __$$UserWiseTableExportImplCopyWithImpl<_$UserWiseTableExportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserWiseTableExportImplToJson(
      this,
    );
  }
}

abstract class _UserWiseTableExport implements UserWiseTableExport {
  const factory _UserWiseTableExport({final String url}) =
      _$UserWiseTableExportImpl;

  factory _UserWiseTableExport.fromJson(Map<String, dynamic> json) =
      _$UserWiseTableExportImpl.fromJson;

  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$UserWiseTableExportImplCopyWith<_$UserWiseTableExportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
