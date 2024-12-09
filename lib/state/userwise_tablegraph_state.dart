import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jsaw_limited/model/update_observation_model.dart';
import 'package:jsaw_limited/model/userwise_tablegraph_model.dart';

part 'userwise_tablegraph_state.freezed.dart';

@freezed
class UserWiseTableGraphState with _$UserWiseTableGraphState {
  const factory UserWiseTableGraphState.loading(List<UserWiseTableGraphModel> userWiseTable) = _Loading;
  const factory UserWiseTableGraphState.content(List<UserWiseTableGraphModel> userWiseTable) = _Content;
  const factory UserWiseTableGraphState.success(List<UserWiseTableGraphModel> userWiseTable) = _Success;
  const factory UserWiseTableGraphState.failed(List<UserWiseTableGraphModel> userWiseTable, String message) =
  _Failed;

  factory UserWiseTableGraphState.initial() => UserWiseTableGraphState.content([]);
}