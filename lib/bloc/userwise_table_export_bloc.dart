import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/departmentgraphExport_state.dart';
import 'package:jsaw_limited/state/generateExcel_state.dart';
import 'package:jsaw_limited/state/userwise_table_export_state.dart';
import '../error/api_error.dart';

class UserWiseTableExportBloc extends Cubit<UserWiseTableExportState>{
  UserWiseTableExportBloc(this.graphService): super(UserWiseTableExportState.initial());

  late GraphService graphService;

  Future<void> initState(String startDate, String endDate, String designation)async {
    try{
      emit(UserWiseTableExportState.loading(state.userWiseTableExport));
      final generateExcel = await graphService.generateUserwiseTableExport(startDate, endDate, designation);
      emit(UserWiseTableExportState.success(generateExcel!, generateExcel.url));
    }on ApiError catch (error) {
      emit(UserWiseTableExportState.failed(state.userWiseTableExport, error.message));
    }
  }
}