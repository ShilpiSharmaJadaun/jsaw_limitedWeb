// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'investigationReport_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InvestigationReportResponse _$InvestigationReportResponseFromJson(
    Map<String, dynamic> json) {
  return _InvestigationReportResponse.fromJson(json);
}

/// @nodoc
mixin _$InvestigationReportResponse {
  int get id => throw _privateConstructorUsedError;
  int get incidentReportId => throw _privateConstructorUsedError;
  String get incidentUniqueId => throw _privateConstructorUsedError;
  String get reportDate => throw _privateConstructorUsedError;
  String get associatedRiskImageUrl => throw _privateConstructorUsedError;
  String get lowQualityImageUrl => throw _privateConstructorUsedError;
  String get highQualityImageUrl => throw _privateConstructorUsedError;
  String get raisedDate => throw _privateConstructorUsedError;
  String get updatedDate => throw _privateConstructorUsedError;
  List<InvestigationTeamItem> get team => throw _privateConstructorUsedError;
  List<InvestigationRootCauseItem> get rootCauses =>
      throw _privateConstructorUsedError;
  List<InvestigationCapaItem> get capa => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvestigationReportResponseCopyWith<InvestigationReportResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvestigationReportResponseCopyWith<$Res> {
  factory $InvestigationReportResponseCopyWith(
          InvestigationReportResponse value,
          $Res Function(InvestigationReportResponse) then) =
      _$InvestigationReportResponseCopyWithImpl<$Res,
          InvestigationReportResponse>;
  @useResult
  $Res call(
      {int id,
      int incidentReportId,
      String incidentUniqueId,
      String reportDate,
      String associatedRiskImageUrl,
      String lowQualityImageUrl,
      String highQualityImageUrl,
      String raisedDate,
      String updatedDate,
      List<InvestigationTeamItem> team,
      List<InvestigationRootCauseItem> rootCauses,
      List<InvestigationCapaItem> capa});
}

/// @nodoc
class _$InvestigationReportResponseCopyWithImpl<$Res,
        $Val extends InvestigationReportResponse>
    implements $InvestigationReportResponseCopyWith<$Res> {
  _$InvestigationReportResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? incidentReportId = null,
    Object? incidentUniqueId = null,
    Object? reportDate = null,
    Object? associatedRiskImageUrl = null,
    Object? lowQualityImageUrl = null,
    Object? highQualityImageUrl = null,
    Object? raisedDate = null,
    Object? updatedDate = null,
    Object? team = null,
    Object? rootCauses = null,
    Object? capa = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      incidentReportId: null == incidentReportId
          ? _value.incidentReportId
          : incidentReportId // ignore: cast_nullable_to_non_nullable
              as int,
      incidentUniqueId: null == incidentUniqueId
          ? _value.incidentUniqueId
          : incidentUniqueId // ignore: cast_nullable_to_non_nullable
              as String,
      reportDate: null == reportDate
          ? _value.reportDate
          : reportDate // ignore: cast_nullable_to_non_nullable
              as String,
      associatedRiskImageUrl: null == associatedRiskImageUrl
          ? _value.associatedRiskImageUrl
          : associatedRiskImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      lowQualityImageUrl: null == lowQualityImageUrl
          ? _value.lowQualityImageUrl
          : lowQualityImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      highQualityImageUrl: null == highQualityImageUrl
          ? _value.highQualityImageUrl
          : highQualityImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      raisedDate: null == raisedDate
          ? _value.raisedDate
          : raisedDate // ignore: cast_nullable_to_non_nullable
              as String,
      updatedDate: null == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String,
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as List<InvestigationTeamItem>,
      rootCauses: null == rootCauses
          ? _value.rootCauses
          : rootCauses // ignore: cast_nullable_to_non_nullable
              as List<InvestigationRootCauseItem>,
      capa: null == capa
          ? _value.capa
          : capa // ignore: cast_nullable_to_non_nullable
              as List<InvestigationCapaItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvestigationReportResponseImplCopyWith<$Res>
    implements $InvestigationReportResponseCopyWith<$Res> {
  factory _$$InvestigationReportResponseImplCopyWith(
          _$InvestigationReportResponseImpl value,
          $Res Function(_$InvestigationReportResponseImpl) then) =
      __$$InvestigationReportResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int incidentReportId,
      String incidentUniqueId,
      String reportDate,
      String associatedRiskImageUrl,
      String lowQualityImageUrl,
      String highQualityImageUrl,
      String raisedDate,
      String updatedDate,
      List<InvestigationTeamItem> team,
      List<InvestigationRootCauseItem> rootCauses,
      List<InvestigationCapaItem> capa});
}

/// @nodoc
class __$$InvestigationReportResponseImplCopyWithImpl<$Res>
    extends _$InvestigationReportResponseCopyWithImpl<$Res,
        _$InvestigationReportResponseImpl>
    implements _$$InvestigationReportResponseImplCopyWith<$Res> {
  __$$InvestigationReportResponseImplCopyWithImpl(
      _$InvestigationReportResponseImpl _value,
      $Res Function(_$InvestigationReportResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? incidentReportId = null,
    Object? incidentUniqueId = null,
    Object? reportDate = null,
    Object? associatedRiskImageUrl = null,
    Object? lowQualityImageUrl = null,
    Object? highQualityImageUrl = null,
    Object? raisedDate = null,
    Object? updatedDate = null,
    Object? team = null,
    Object? rootCauses = null,
    Object? capa = null,
  }) {
    return _then(_$InvestigationReportResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      incidentReportId: null == incidentReportId
          ? _value.incidentReportId
          : incidentReportId // ignore: cast_nullable_to_non_nullable
              as int,
      incidentUniqueId: null == incidentUniqueId
          ? _value.incidentUniqueId
          : incidentUniqueId // ignore: cast_nullable_to_non_nullable
              as String,
      reportDate: null == reportDate
          ? _value.reportDate
          : reportDate // ignore: cast_nullable_to_non_nullable
              as String,
      associatedRiskImageUrl: null == associatedRiskImageUrl
          ? _value.associatedRiskImageUrl
          : associatedRiskImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      lowQualityImageUrl: null == lowQualityImageUrl
          ? _value.lowQualityImageUrl
          : lowQualityImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      highQualityImageUrl: null == highQualityImageUrl
          ? _value.highQualityImageUrl
          : highQualityImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      raisedDate: null == raisedDate
          ? _value.raisedDate
          : raisedDate // ignore: cast_nullable_to_non_nullable
              as String,
      updatedDate: null == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String,
      team: null == team
          ? _value._team
          : team // ignore: cast_nullable_to_non_nullable
              as List<InvestigationTeamItem>,
      rootCauses: null == rootCauses
          ? _value._rootCauses
          : rootCauses // ignore: cast_nullable_to_non_nullable
              as List<InvestigationRootCauseItem>,
      capa: null == capa
          ? _value._capa
          : capa // ignore: cast_nullable_to_non_nullable
              as List<InvestigationCapaItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvestigationReportResponseImpl
    implements _InvestigationReportResponse {
  const _$InvestigationReportResponseImpl(
      {this.id = 0,
      this.incidentReportId = 0,
      this.incidentUniqueId = "",
      this.reportDate = "",
      this.associatedRiskImageUrl = "",
      this.lowQualityImageUrl = "",
      this.highQualityImageUrl = "",
      this.raisedDate = "",
      this.updatedDate = "",
      final List<InvestigationTeamItem> team = const [],
      final List<InvestigationRootCauseItem> rootCauses = const [],
      final List<InvestigationCapaItem> capa = const []})
      : _team = team,
        _rootCauses = rootCauses,
        _capa = capa;

  factory _$InvestigationReportResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$InvestigationReportResponseImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int incidentReportId;
  @override
  @JsonKey()
  final String incidentUniqueId;
  @override
  @JsonKey()
  final String reportDate;
  @override
  @JsonKey()
  final String associatedRiskImageUrl;
  @override
  @JsonKey()
  final String lowQualityImageUrl;
  @override
  @JsonKey()
  final String highQualityImageUrl;
  @override
  @JsonKey()
  final String raisedDate;
  @override
  @JsonKey()
  final String updatedDate;
  final List<InvestigationTeamItem> _team;
  @override
  @JsonKey()
  List<InvestigationTeamItem> get team {
    if (_team is EqualUnmodifiableListView) return _team;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_team);
  }

  final List<InvestigationRootCauseItem> _rootCauses;
  @override
  @JsonKey()
  List<InvestigationRootCauseItem> get rootCauses {
    if (_rootCauses is EqualUnmodifiableListView) return _rootCauses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rootCauses);
  }

  final List<InvestigationCapaItem> _capa;
  @override
  @JsonKey()
  List<InvestigationCapaItem> get capa {
    if (_capa is EqualUnmodifiableListView) return _capa;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_capa);
  }

  @override
  String toString() {
    return 'InvestigationReportResponse(id: $id, incidentReportId: $incidentReportId, incidentUniqueId: $incidentUniqueId, reportDate: $reportDate, associatedRiskImageUrl: $associatedRiskImageUrl, lowQualityImageUrl: $lowQualityImageUrl, highQualityImageUrl: $highQualityImageUrl, raisedDate: $raisedDate, updatedDate: $updatedDate, team: $team, rootCauses: $rootCauses, capa: $capa)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvestigationReportResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.incidentReportId, incidentReportId) ||
                other.incidentReportId == incidentReportId) &&
            (identical(other.incidentUniqueId, incidentUniqueId) ||
                other.incidentUniqueId == incidentUniqueId) &&
            (identical(other.reportDate, reportDate) ||
                other.reportDate == reportDate) &&
            (identical(other.associatedRiskImageUrl, associatedRiskImageUrl) ||
                other.associatedRiskImageUrl == associatedRiskImageUrl) &&
            (identical(other.lowQualityImageUrl, lowQualityImageUrl) ||
                other.lowQualityImageUrl == lowQualityImageUrl) &&
            (identical(other.highQualityImageUrl, highQualityImageUrl) ||
                other.highQualityImageUrl == highQualityImageUrl) &&
            (identical(other.raisedDate, raisedDate) ||
                other.raisedDate == raisedDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            const DeepCollectionEquality().equals(other._team, _team) &&
            const DeepCollectionEquality()
                .equals(other._rootCauses, _rootCauses) &&
            const DeepCollectionEquality().equals(other._capa, _capa));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      incidentReportId,
      incidentUniqueId,
      reportDate,
      associatedRiskImageUrl,
      lowQualityImageUrl,
      highQualityImageUrl,
      raisedDate,
      updatedDate,
      const DeepCollectionEquality().hash(_team),
      const DeepCollectionEquality().hash(_rootCauses),
      const DeepCollectionEquality().hash(_capa));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvestigationReportResponseImplCopyWith<_$InvestigationReportResponseImpl>
      get copyWith => __$$InvestigationReportResponseImplCopyWithImpl<
          _$InvestigationReportResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvestigationReportResponseImplToJson(
      this,
    );
  }
}

abstract class _InvestigationReportResponse
    implements InvestigationReportResponse {
  const factory _InvestigationReportResponse(
          {final int id,
          final int incidentReportId,
          final String incidentUniqueId,
          final String reportDate,
          final String associatedRiskImageUrl,
          final String lowQualityImageUrl,
          final String highQualityImageUrl,
          final String raisedDate,
          final String updatedDate,
          final List<InvestigationTeamItem> team,
          final List<InvestigationRootCauseItem> rootCauses,
          final List<InvestigationCapaItem> capa}) =
      _$InvestigationReportResponseImpl;

  factory _InvestigationReportResponse.fromJson(Map<String, dynamic> json) =
      _$InvestigationReportResponseImpl.fromJson;

  @override
  int get id;
  @override
  int get incidentReportId;
  @override
  String get incidentUniqueId;
  @override
  String get reportDate;
  @override
  String get associatedRiskImageUrl;
  @override
  String get lowQualityImageUrl;
  @override
  String get highQualityImageUrl;
  @override
  String get raisedDate;
  @override
  String get updatedDate;
  @override
  List<InvestigationTeamItem> get team;
  @override
  List<InvestigationRootCauseItem> get rootCauses;
  @override
  List<InvestigationCapaItem> get capa;
  @override
  @JsonKey(ignore: true)
  _$$InvestigationReportResponseImplCopyWith<_$InvestigationReportResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InvestigationTeamItem _$InvestigationTeamItemFromJson(
    Map<String, dynamic> json) {
  return _InvestigationTeamItem.fromJson(json);
}

/// @nodoc
mixin _$InvestigationTeamItem {
  int get id => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  String get empUnqId => throw _privateConstructorUsedError;
  String get empName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvestigationTeamItemCopyWith<InvestigationTeamItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvestigationTeamItemCopyWith<$Res> {
  factory $InvestigationTeamItemCopyWith(InvestigationTeamItem value,
          $Res Function(InvestigationTeamItem) then) =
      _$InvestigationTeamItemCopyWithImpl<$Res, InvestigationTeamItem>;
  @useResult
  $Res call({int id, int seq, String empUnqId, String empName});
}

/// @nodoc
class _$InvestigationTeamItemCopyWithImpl<$Res,
        $Val extends InvestigationTeamItem>
    implements $InvestigationTeamItemCopyWith<$Res> {
  _$InvestigationTeamItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seq = null,
    Object? empUnqId = null,
    Object? empName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      empUnqId: null == empUnqId
          ? _value.empUnqId
          : empUnqId // ignore: cast_nullable_to_non_nullable
              as String,
      empName: null == empName
          ? _value.empName
          : empName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvestigationTeamItemImplCopyWith<$Res>
    implements $InvestigationTeamItemCopyWith<$Res> {
  factory _$$InvestigationTeamItemImplCopyWith(
          _$InvestigationTeamItemImpl value,
          $Res Function(_$InvestigationTeamItemImpl) then) =
      __$$InvestigationTeamItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int seq, String empUnqId, String empName});
}

/// @nodoc
class __$$InvestigationTeamItemImplCopyWithImpl<$Res>
    extends _$InvestigationTeamItemCopyWithImpl<$Res,
        _$InvestigationTeamItemImpl>
    implements _$$InvestigationTeamItemImplCopyWith<$Res> {
  __$$InvestigationTeamItemImplCopyWithImpl(_$InvestigationTeamItemImpl _value,
      $Res Function(_$InvestigationTeamItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seq = null,
    Object? empUnqId = null,
    Object? empName = null,
  }) {
    return _then(_$InvestigationTeamItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      empUnqId: null == empUnqId
          ? _value.empUnqId
          : empUnqId // ignore: cast_nullable_to_non_nullable
              as String,
      empName: null == empName
          ? _value.empName
          : empName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvestigationTeamItemImpl implements _InvestigationTeamItem {
  const _$InvestigationTeamItemImpl(
      {this.id = 0, this.seq = 0, this.empUnqId = "", this.empName = ""});

  factory _$InvestigationTeamItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvestigationTeamItemImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int seq;
  @override
  @JsonKey()
  final String empUnqId;
  @override
  @JsonKey()
  final String empName;

  @override
  String toString() {
    return 'InvestigationTeamItem(id: $id, seq: $seq, empUnqId: $empUnqId, empName: $empName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvestigationTeamItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.empUnqId, empUnqId) ||
                other.empUnqId == empUnqId) &&
            (identical(other.empName, empName) || other.empName == empName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, seq, empUnqId, empName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvestigationTeamItemImplCopyWith<_$InvestigationTeamItemImpl>
      get copyWith => __$$InvestigationTeamItemImplCopyWithImpl<
          _$InvestigationTeamItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvestigationTeamItemImplToJson(
      this,
    );
  }
}

abstract class _InvestigationTeamItem implements InvestigationTeamItem {
  const factory _InvestigationTeamItem(
      {final int id,
      final int seq,
      final String empUnqId,
      final String empName}) = _$InvestigationTeamItemImpl;

  factory _InvestigationTeamItem.fromJson(Map<String, dynamic> json) =
      _$InvestigationTeamItemImpl.fromJson;

  @override
  int get id;
  @override
  int get seq;
  @override
  String get empUnqId;
  @override
  String get empName;
  @override
  @JsonKey(ignore: true)
  _$$InvestigationTeamItemImplCopyWith<_$InvestigationTeamItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InvestigationRootCauseItem _$InvestigationRootCauseItemFromJson(
    Map<String, dynamic> json) {
  return _InvestigationRootCauseItem.fromJson(json);
}

/// @nodoc
mixin _$InvestigationRootCauseItem {
  int get id => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  String get rootCauseText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvestigationRootCauseItemCopyWith<InvestigationRootCauseItem>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvestigationRootCauseItemCopyWith<$Res> {
  factory $InvestigationRootCauseItemCopyWith(InvestigationRootCauseItem value,
          $Res Function(InvestigationRootCauseItem) then) =
      _$InvestigationRootCauseItemCopyWithImpl<$Res,
          InvestigationRootCauseItem>;
  @useResult
  $Res call({int id, int seq, String rootCauseText});
}

/// @nodoc
class _$InvestigationRootCauseItemCopyWithImpl<$Res,
        $Val extends InvestigationRootCauseItem>
    implements $InvestigationRootCauseItemCopyWith<$Res> {
  _$InvestigationRootCauseItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seq = null,
    Object? rootCauseText = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      rootCauseText: null == rootCauseText
          ? _value.rootCauseText
          : rootCauseText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvestigationRootCauseItemImplCopyWith<$Res>
    implements $InvestigationRootCauseItemCopyWith<$Res> {
  factory _$$InvestigationRootCauseItemImplCopyWith(
          _$InvestigationRootCauseItemImpl value,
          $Res Function(_$InvestigationRootCauseItemImpl) then) =
      __$$InvestigationRootCauseItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int seq, String rootCauseText});
}

/// @nodoc
class __$$InvestigationRootCauseItemImplCopyWithImpl<$Res>
    extends _$InvestigationRootCauseItemCopyWithImpl<$Res,
        _$InvestigationRootCauseItemImpl>
    implements _$$InvestigationRootCauseItemImplCopyWith<$Res> {
  __$$InvestigationRootCauseItemImplCopyWithImpl(
      _$InvestigationRootCauseItemImpl _value,
      $Res Function(_$InvestigationRootCauseItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seq = null,
    Object? rootCauseText = null,
  }) {
    return _then(_$InvestigationRootCauseItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      rootCauseText: null == rootCauseText
          ? _value.rootCauseText
          : rootCauseText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvestigationRootCauseItemImpl implements _InvestigationRootCauseItem {
  const _$InvestigationRootCauseItemImpl(
      {this.id = 0, this.seq = 0, this.rootCauseText = ""});

  factory _$InvestigationRootCauseItemImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$InvestigationRootCauseItemImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int seq;
  @override
  @JsonKey()
  final String rootCauseText;

  @override
  String toString() {
    return 'InvestigationRootCauseItem(id: $id, seq: $seq, rootCauseText: $rootCauseText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvestigationRootCauseItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.rootCauseText, rootCauseText) ||
                other.rootCauseText == rootCauseText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, seq, rootCauseText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvestigationRootCauseItemImplCopyWith<_$InvestigationRootCauseItemImpl>
      get copyWith => __$$InvestigationRootCauseItemImplCopyWithImpl<
          _$InvestigationRootCauseItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvestigationRootCauseItemImplToJson(
      this,
    );
  }
}

abstract class _InvestigationRootCauseItem
    implements InvestigationRootCauseItem {
  const factory _InvestigationRootCauseItem(
      {final int id,
      final int seq,
      final String rootCauseText}) = _$InvestigationRootCauseItemImpl;

  factory _InvestigationRootCauseItem.fromJson(Map<String, dynamic> json) =
      _$InvestigationRootCauseItemImpl.fromJson;

  @override
  int get id;
  @override
  int get seq;
  @override
  String get rootCauseText;
  @override
  @JsonKey(ignore: true)
  _$$InvestigationRootCauseItemImplCopyWith<_$InvestigationRootCauseItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InvestigationCapaItem _$InvestigationCapaItemFromJson(
    Map<String, dynamic> json) {
  return _InvestigationCapaItem.fromJson(json);
}

/// @nodoc
mixin _$InvestigationCapaItem {
  int get id => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  String get capaText => throw _privateConstructorUsedError;
  String get respEmpCode => throw _privateConstructorUsedError;
  String get respEmpName => throw _privateConstructorUsedError;
  String get respDeptCode => throw _privateConstructorUsedError;
  String get targetDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvestigationCapaItemCopyWith<InvestigationCapaItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvestigationCapaItemCopyWith<$Res> {
  factory $InvestigationCapaItemCopyWith(InvestigationCapaItem value,
          $Res Function(InvestigationCapaItem) then) =
      _$InvestigationCapaItemCopyWithImpl<$Res, InvestigationCapaItem>;
  @useResult
  $Res call(
      {int id,
      int seq,
      String capaText,
      String respEmpCode,
      String respEmpName,
      String respDeptCode,
      String targetDate});
}

/// @nodoc
class _$InvestigationCapaItemCopyWithImpl<$Res,
        $Val extends InvestigationCapaItem>
    implements $InvestigationCapaItemCopyWith<$Res> {
  _$InvestigationCapaItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seq = null,
    Object? capaText = null,
    Object? respEmpCode = null,
    Object? respEmpName = null,
    Object? respDeptCode = null,
    Object? targetDate = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      capaText: null == capaText
          ? _value.capaText
          : capaText // ignore: cast_nullable_to_non_nullable
              as String,
      respEmpCode: null == respEmpCode
          ? _value.respEmpCode
          : respEmpCode // ignore: cast_nullable_to_non_nullable
              as String,
      respEmpName: null == respEmpName
          ? _value.respEmpName
          : respEmpName // ignore: cast_nullable_to_non_nullable
              as String,
      respDeptCode: null == respDeptCode
          ? _value.respDeptCode
          : respDeptCode // ignore: cast_nullable_to_non_nullable
              as String,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvestigationCapaItemImplCopyWith<$Res>
    implements $InvestigationCapaItemCopyWith<$Res> {
  factory _$$InvestigationCapaItemImplCopyWith(
          _$InvestigationCapaItemImpl value,
          $Res Function(_$InvestigationCapaItemImpl) then) =
      __$$InvestigationCapaItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int seq,
      String capaText,
      String respEmpCode,
      String respEmpName,
      String respDeptCode,
      String targetDate});
}

/// @nodoc
class __$$InvestigationCapaItemImplCopyWithImpl<$Res>
    extends _$InvestigationCapaItemCopyWithImpl<$Res,
        _$InvestigationCapaItemImpl>
    implements _$$InvestigationCapaItemImplCopyWith<$Res> {
  __$$InvestigationCapaItemImplCopyWithImpl(_$InvestigationCapaItemImpl _value,
      $Res Function(_$InvestigationCapaItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seq = null,
    Object? capaText = null,
    Object? respEmpCode = null,
    Object? respEmpName = null,
    Object? respDeptCode = null,
    Object? targetDate = null,
  }) {
    return _then(_$InvestigationCapaItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      capaText: null == capaText
          ? _value.capaText
          : capaText // ignore: cast_nullable_to_non_nullable
              as String,
      respEmpCode: null == respEmpCode
          ? _value.respEmpCode
          : respEmpCode // ignore: cast_nullable_to_non_nullable
              as String,
      respEmpName: null == respEmpName
          ? _value.respEmpName
          : respEmpName // ignore: cast_nullable_to_non_nullable
              as String,
      respDeptCode: null == respDeptCode
          ? _value.respDeptCode
          : respDeptCode // ignore: cast_nullable_to_non_nullable
              as String,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvestigationCapaItemImpl implements _InvestigationCapaItem {
  const _$InvestigationCapaItemImpl(
      {this.id = 0,
      this.seq = 0,
      this.capaText = "",
      this.respEmpCode = "",
      this.respEmpName = "",
      this.respDeptCode = "",
      this.targetDate = ""});

  factory _$InvestigationCapaItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvestigationCapaItemImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int seq;
  @override
  @JsonKey()
  final String capaText;
  @override
  @JsonKey()
  final String respEmpCode;
  @override
  @JsonKey()
  final String respEmpName;
  @override
  @JsonKey()
  final String respDeptCode;
  @override
  @JsonKey()
  final String targetDate;

  @override
  String toString() {
    return 'InvestigationCapaItem(id: $id, seq: $seq, capaText: $capaText, respEmpCode: $respEmpCode, respEmpName: $respEmpName, respDeptCode: $respDeptCode, targetDate: $targetDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvestigationCapaItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.capaText, capaText) ||
                other.capaText == capaText) &&
            (identical(other.respEmpCode, respEmpCode) ||
                other.respEmpCode == respEmpCode) &&
            (identical(other.respEmpName, respEmpName) ||
                other.respEmpName == respEmpName) &&
            (identical(other.respDeptCode, respDeptCode) ||
                other.respDeptCode == respDeptCode) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, seq, capaText, respEmpCode,
      respEmpName, respDeptCode, targetDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvestigationCapaItemImplCopyWith<_$InvestigationCapaItemImpl>
      get copyWith => __$$InvestigationCapaItemImplCopyWithImpl<
          _$InvestigationCapaItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvestigationCapaItemImplToJson(
      this,
    );
  }
}

abstract class _InvestigationCapaItem implements InvestigationCapaItem {
  const factory _InvestigationCapaItem(
      {final int id,
      final int seq,
      final String capaText,
      final String respEmpCode,
      final String respEmpName,
      final String respDeptCode,
      final String targetDate}) = _$InvestigationCapaItemImpl;

  factory _InvestigationCapaItem.fromJson(Map<String, dynamic> json) =
      _$InvestigationCapaItemImpl.fromJson;

  @override
  int get id;
  @override
  int get seq;
  @override
  String get capaText;
  @override
  String get respEmpCode;
  @override
  String get respEmpName;
  @override
  String get respDeptCode;
  @override
  String get targetDate;
  @override
  @JsonKey(ignore: true)
  _$$InvestigationCapaItemImplCopyWith<_$InvestigationCapaItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}
