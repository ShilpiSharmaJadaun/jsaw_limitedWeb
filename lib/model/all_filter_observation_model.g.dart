// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_filter_observation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllFilterObservationModelImpl _$$AllFilterObservationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllFilterObservationModelImpl(
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      totalItems: (json['totalItems'] as num?)?.toInt() ?? 0,
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 0,
      sessionID: json['sessionID'] as String? ?? "",
      model: (json['model'] as List<dynamic>?)
              ?.map((e) =>
                  FilterObservationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FilterObservationModel>[],
    );

Map<String, dynamic> _$$AllFilterObservationModelImplToJson(
        _$AllFilterObservationModelImpl instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'currentPage': instance.currentPage,
      'sessionID': instance.sessionID,
      'model': instance.model,
    };
