// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'graph2main_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Graph2MainModel _$Graph2MainModelFromJson(Map<String, dynamic> json) {
  return _Graph2MainModel.fromJson(json);
}

/// @nodoc
mixin _$Graph2MainModel {
  int get totalPages => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  String get sessionID => throw _privateConstructorUsedError;
  bool get status => throw _privateConstructorUsedError;
  List<Graph2Model> get model => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Graph2MainModelCopyWith<Graph2MainModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Graph2MainModelCopyWith<$Res> {
  factory $Graph2MainModelCopyWith(
          Graph2MainModel value, $Res Function(Graph2MainModel) then) =
      _$Graph2MainModelCopyWithImpl<$Res, Graph2MainModel>;
  @useResult
  $Res call(
      {int totalPages,
      int totalItems,
      int currentPage,
      String msg,
      String sessionID,
      bool status,
      List<Graph2Model> model});
}

/// @nodoc
class _$Graph2MainModelCopyWithImpl<$Res, $Val extends Graph2MainModel>
    implements $Graph2MainModelCopyWith<$Res> {
  _$Graph2MainModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPages = null,
    Object? totalItems = null,
    Object? currentPage = null,
    Object? msg = null,
    Object? sessionID = null,
    Object? status = null,
    Object? model = null,
  }) {
    return _then(_value.copyWith(
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      sessionID: null == sessionID
          ? _value.sessionID
          : sessionID // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as List<Graph2Model>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Graph2MainModelImplCopyWith<$Res>
    implements $Graph2MainModelCopyWith<$Res> {
  factory _$$Graph2MainModelImplCopyWith(_$Graph2MainModelImpl value,
          $Res Function(_$Graph2MainModelImpl) then) =
      __$$Graph2MainModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalPages,
      int totalItems,
      int currentPage,
      String msg,
      String sessionID,
      bool status,
      List<Graph2Model> model});
}

/// @nodoc
class __$$Graph2MainModelImplCopyWithImpl<$Res>
    extends _$Graph2MainModelCopyWithImpl<$Res, _$Graph2MainModelImpl>
    implements _$$Graph2MainModelImplCopyWith<$Res> {
  __$$Graph2MainModelImplCopyWithImpl(
      _$Graph2MainModelImpl _value, $Res Function(_$Graph2MainModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPages = null,
    Object? totalItems = null,
    Object? currentPage = null,
    Object? msg = null,
    Object? sessionID = null,
    Object? status = null,
    Object? model = null,
  }) {
    return _then(_$Graph2MainModelImpl(
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      sessionID: null == sessionID
          ? _value.sessionID
          : sessionID // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      model: null == model
          ? _value._model
          : model // ignore: cast_nullable_to_non_nullable
              as List<Graph2Model>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Graph2MainModelImpl implements _Graph2MainModel {
  const _$Graph2MainModelImpl(
      {this.totalPages = 0,
      this.totalItems = 0,
      this.currentPage = 0,
      this.msg = '',
      this.sessionID = '',
      this.status = false,
      final List<Graph2Model> model = const <Graph2Model>[]})
      : _model = model;

  factory _$Graph2MainModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Graph2MainModelImplFromJson(json);

  @override
  @JsonKey()
  final int totalPages;
  @override
  @JsonKey()
  final int totalItems;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final String msg;
  @override
  @JsonKey()
  final String sessionID;
  @override
  @JsonKey()
  final bool status;
  final List<Graph2Model> _model;
  @override
  @JsonKey()
  List<Graph2Model> get model {
    if (_model is EqualUnmodifiableListView) return _model;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_model);
  }

  @override
  String toString() {
    return 'Graph2MainModel(totalPages: $totalPages, totalItems: $totalItems, currentPage: $currentPage, msg: $msg, sessionID: $sessionID, status: $status, model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Graph2MainModelImpl &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.sessionID, sessionID) ||
                other.sessionID == sessionID) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._model, _model));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalPages,
      totalItems,
      currentPage,
      msg,
      sessionID,
      status,
      const DeepCollectionEquality().hash(_model));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Graph2MainModelImplCopyWith<_$Graph2MainModelImpl> get copyWith =>
      __$$Graph2MainModelImplCopyWithImpl<_$Graph2MainModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Graph2MainModelImplToJson(
      this,
    );
  }
}

abstract class _Graph2MainModel implements Graph2MainModel {
  const factory _Graph2MainModel(
      {final int totalPages,
      final int totalItems,
      final int currentPage,
      final String msg,
      final String sessionID,
      final bool status,
      final List<Graph2Model> model}) = _$Graph2MainModelImpl;

  factory _Graph2MainModel.fromJson(Map<String, dynamic> json) =
      _$Graph2MainModelImpl.fromJson;

  @override
  int get totalPages;
  @override
  int get totalItems;
  @override
  int get currentPage;
  @override
  String get msg;
  @override
  String get sessionID;
  @override
  bool get status;
  @override
  List<Graph2Model> get model;
  @override
  @JsonKey(ignore: true)
  _$$Graph2MainModelImplCopyWith<_$Graph2MainModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
