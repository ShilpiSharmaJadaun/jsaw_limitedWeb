// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_filter_observation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllFilterObservationModel _$AllFilterObservationModelFromJson(
    Map<String, dynamic> json) {
  return _AllFilterObservationModel.fromJson(json);
}

/// @nodoc
mixin _$AllFilterObservationModel {
  int get totalPages => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  String get sessionID => throw _privateConstructorUsedError;
  List<FilterObservationModel> get model => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllFilterObservationModelCopyWith<AllFilterObservationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllFilterObservationModelCopyWith<$Res> {
  factory $AllFilterObservationModelCopyWith(AllFilterObservationModel value,
          $Res Function(AllFilterObservationModel) then) =
      _$AllFilterObservationModelCopyWithImpl<$Res, AllFilterObservationModel>;
  @useResult
  $Res call(
      {int totalPages,
      int totalItems,
      int currentPage,
      String sessionID,
      List<FilterObservationModel> model});
}

/// @nodoc
class _$AllFilterObservationModelCopyWithImpl<$Res,
        $Val extends AllFilterObservationModel>
    implements $AllFilterObservationModelCopyWith<$Res> {
  _$AllFilterObservationModelCopyWithImpl(this._value, this._then);

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
    Object? sessionID = null,
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
      sessionID: null == sessionID
          ? _value.sessionID
          : sessionID // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as List<FilterObservationModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllFilterObservationModelImplCopyWith<$Res>
    implements $AllFilterObservationModelCopyWith<$Res> {
  factory _$$AllFilterObservationModelImplCopyWith(
          _$AllFilterObservationModelImpl value,
          $Res Function(_$AllFilterObservationModelImpl) then) =
      __$$AllFilterObservationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalPages,
      int totalItems,
      int currentPage,
      String sessionID,
      List<FilterObservationModel> model});
}

/// @nodoc
class __$$AllFilterObservationModelImplCopyWithImpl<$Res>
    extends _$AllFilterObservationModelCopyWithImpl<$Res,
        _$AllFilterObservationModelImpl>
    implements _$$AllFilterObservationModelImplCopyWith<$Res> {
  __$$AllFilterObservationModelImplCopyWithImpl(
      _$AllFilterObservationModelImpl _value,
      $Res Function(_$AllFilterObservationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPages = null,
    Object? totalItems = null,
    Object? currentPage = null,
    Object? sessionID = null,
    Object? model = null,
  }) {
    return _then(_$AllFilterObservationModelImpl(
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
      sessionID: null == sessionID
          ? _value.sessionID
          : sessionID // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value._model
          : model // ignore: cast_nullable_to_non_nullable
              as List<FilterObservationModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllFilterObservationModelImpl implements _AllFilterObservationModel {
  const _$AllFilterObservationModelImpl(
      {this.totalPages = 0,
      this.totalItems = 0,
      this.currentPage = 0,
      this.sessionID = "",
      final List<FilterObservationModel> model =
          const <FilterObservationModel>[]})
      : _model = model;

  factory _$AllFilterObservationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllFilterObservationModelImplFromJson(json);

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
  final String sessionID;
  final List<FilterObservationModel> _model;
  @override
  @JsonKey()
  List<FilterObservationModel> get model {
    if (_model is EqualUnmodifiableListView) return _model;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_model);
  }

  @override
  String toString() {
    return 'AllFilterObservationModel(totalPages: $totalPages, totalItems: $totalItems, currentPage: $currentPage, sessionID: $sessionID, model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllFilterObservationModelImpl &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.sessionID, sessionID) ||
                other.sessionID == sessionID) &&
            const DeepCollectionEquality().equals(other._model, _model));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalPages, totalItems,
      currentPage, sessionID, const DeepCollectionEquality().hash(_model));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllFilterObservationModelImplCopyWith<_$AllFilterObservationModelImpl>
      get copyWith => __$$AllFilterObservationModelImplCopyWithImpl<
          _$AllFilterObservationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllFilterObservationModelImplToJson(
      this,
    );
  }
}

abstract class _AllFilterObservationModel implements AllFilterObservationModel {
  const factory _AllFilterObservationModel(
          {final int totalPages,
          final int totalItems,
          final int currentPage,
          final String sessionID,
          final List<FilterObservationModel> model}) =
      _$AllFilterObservationModelImpl;

  factory _AllFilterObservationModel.fromJson(Map<String, dynamic> json) =
      _$AllFilterObservationModelImpl.fromJson;

  @override
  int get totalPages;
  @override
  int get totalItems;
  @override
  int get currentPage;
  @override
  String get sessionID;
  @override
  List<FilterObservationModel> get model;
  @override
  @JsonKey(ignore: true)
  _$$AllFilterObservationModelImplCopyWith<_$AllFilterObservationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
