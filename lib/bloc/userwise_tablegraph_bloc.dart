import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/userwise_tablegraph_state.dart';


class UserWiseTableGraphBloc extends Cubit<UserWiseTableGraphState> {
  UserWiseTableGraphBloc( this.graphService)
      : super(UserWiseTableGraphState.initial());

  late GraphService graphService;

  Future<void> init(String startDate, String endDate,String designationCode) async {
    emit(UserWiseTableGraphState.loading(state.userWiseTable));
    final userWiseData = await graphService.getUserwiseData(startDate, endDate, designationCode);
    emit(UserWiseTableGraphState.content(userWiseData));
  }
}