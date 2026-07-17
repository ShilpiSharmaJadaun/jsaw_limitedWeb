import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/departmentgraphExport_state.dart';
import '../error/api_error.dart';

class DepartmentRaisedGraphExportBloc extends Cubit<DepartmentgraphExportState>{
  DepartmentRaisedGraphExportBloc(this.graphService): super(DepartmentgraphExportState.initial());

  late GraphService graphService;

  Future<void> initState()async {
    try{
      emit(DepartmentgraphExportState.loading(state.departgraphExport));
      final generateExcel = await graphService.generateRaisedExport();
      emit(DepartmentgraphExportState.success(generateExcel!, generateExcel.url));
    }on ApiError catch (error) {
      emit(DepartmentgraphExportState.failed(state.departgraphExport, error.message));
    }
  }
}
