import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/allDesignation_state.dart';
import '../error/api_error.dart';

class AllDesignationBloc extends Cubit<AllDesignationState>{
  AllDesignationBloc(this.graphService): super(AllDesignationState.initial());

  late GraphService graphService;

  Future<void> initState()async {
    try{
      emit(AllDesignationState.loading(state.allDesignation));
      final allDepartlist = await graphService.getAllDesignation();
      emit(AllDesignationState.success(allDepartlist));
    }on ApiError catch (error) {
      emit(AllDesignationState.failed(state.allDesignation, error.message));
    }
  }
}