import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/location_model.dart';

part 'location_state.freezed.dart';

@freezed
class LocationState with _$LocationState{

  const factory LocationState.loading (List<LocationModel> locationModel) = _Loading;
  const factory LocationState.content (List<LocationModel> locationModel) = _Content;
  const factory LocationState.success (List<LocationModel> locationModel) = _Success;
  const factory LocationState.failed (List<LocationModel> locationModel, String msg) = _Failed;

  factory LocationState.initial() => LocationState.content([]);

}