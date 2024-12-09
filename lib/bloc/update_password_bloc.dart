import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/password_service.dart';
import 'package:jsaw_limited/state/update_password_state.dart';
import '../error/api_error.dart';


class UpdatePasswordBloc extends Cubit<UpdatePasswordState>{
  UpdatePasswordBloc(this.passwordService): super(UpdatePasswordState.initial());

  PasswordService passwordService;

  Future<void> forgetPassword(Map<String, dynamic> data)async{
    emit(UpdatePasswordState.loading(state.updatePassword));
    try{
      final message = await passwordService.updatePassword(data);

      emit(UpdatePasswordState.success(state.updatePassword, message));
    }on ApiError catch(error){
      emit(UpdatePasswordState.failed(state.updatePassword,  error.message));
    }
  }

}