import 'package:bloc/bloc.dart';
import 'package:jsaw_limited/model/allplant_model.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/allplant_state.dart';
import '../error/api_error.dart';

class AllPlantBloc extends Cubit<AllPlantState>{
  AllPlantBloc(this.observationService): super(AllPlantState.initial());

  late ObservationService observationService;

  var _allPlantList = <AllPlantModel>[];

  Future<void> initState()async {
    try{
      emit(AllPlantState.loading(state.allPlantModel));
      final plantList = await observationService.getAllPlant();
      _allPlantList = plantList;
      emit(AllPlantState.success(plantList));
    }on ApiError catch (error) {
      print(error);
      emit(AllPlantState.failed(state.allPlantModel, error.message));
    }
  }

  void filterBasedOn(String query){
    if(query.isEmpty){
      emit(AllPlantState.content(_allPlantList));
    }
    final filteredComplaints = <AllPlantModel>[];
    for(AllPlantModel complaint in _allPlantList){
      if(complaint.isSearched(query)) filteredComplaints.add(complaint);
    }
    emit(AllPlantState.content(filteredComplaints));
  }
}