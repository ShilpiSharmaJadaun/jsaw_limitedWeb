//
// import 'package:bloc/bloc.dart';
// import 'package:jsaw_limited/service/observation_service.dart';
// import 'package:jsaw_limited/state/allobservation_state.dart';
//
// import '../error/api_error.dart';
//
// class AllObservationBloc extends Cubit<AllObservationState>{
//   AllObservationBloc(this.observationService): super(AllObservationState.initial());
//
//   late ObservationService observationService;
//
//   Future<void> initState()async {
//     try{
//       emit(AllObservationState.loading(state.divisionModel));
//       final divisionList = await observationService.getAllObservation();
//       emit(AllObservationState.success(divisionList));
//     }on ApiError catch (error) {
//       emit(AllObservationState.failed(state.divisionModel, error.message));
//     }
//   }
// }