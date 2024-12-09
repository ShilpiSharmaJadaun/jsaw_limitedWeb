import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/graph2_state.dart';
import '../error/api_error.dart';

class Graph2Bloc extends Cubit<Graph2State>{
  Graph2Bloc(this.graphService): super(Graph2State.initial());

  late GraphService graphService;

  Future<void> initState(String startDate, String endDate)async {
    try{
      emit(Graph2State.loading(state.graph2Models));
      final divisionList = await graphService.getGraph2Data(startDate, endDate);
      emit(Graph2State.success(divisionList));
    }on ApiError catch (error) {
      emit(Graph2State.failed(state.graph2Models, error.toString()));
    }
  }
}