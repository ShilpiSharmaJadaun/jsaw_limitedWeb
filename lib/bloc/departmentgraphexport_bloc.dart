import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/departmentgraphExport_state.dart';
import 'package:jsaw_limited/state/generateExcel_state.dart';
import '../error/api_error.dart';

class DepartmentgraphExportBloc extends Cubit<DepartmentgraphExportState>{
  DepartmentgraphExportBloc(this.graphService): super(DepartmentgraphExportState.initial());

  late GraphService graphService;

  Future<void> initState()async {
    try{
      emit(DepartmentgraphExportState.loading(state.departgraphExport));
      final generateExcel = await graphService.generateExport();
      emit(DepartmentgraphExportState.success(generateExcel!, generateExcel.url));
    }on ApiError catch (error) {
      emit(DepartmentgraphExportState.failed(state.departgraphExport, error.message));
    }
  }
}