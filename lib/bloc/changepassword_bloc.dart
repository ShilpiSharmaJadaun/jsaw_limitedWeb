import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/password_service.dart';
import 'package:jsaw_limited/state/changepassword_state.dart';
import '../error/api_error.dart';


class ChangepasswordBloc extends Cubit<ChangepasswordState>{
  ChangepasswordBloc(this.passwordService): super(ChangepasswordState.initial());

  PasswordService passwordService;

  Future<void> forgetPassword(Map<String, dynamic> data)async{
    emit(ChangepasswordState.loading(state.changePassword));
    try{
      final message = await passwordService.changePassword(data);

      emit(ChangepasswordState.success(state.changePassword, message));
    }on ApiError catch(error){
      emit(ChangepasswordState.failed(state.changePassword,  error.message));
    }
  }

}