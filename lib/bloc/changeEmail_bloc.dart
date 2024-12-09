import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/service/password_service.dart';
import 'package:jsaw_limited/state/changepassword_state.dart';
import 'package:jsaw_limited/state/chnageEmail_state.dart';
import '../error/api_error.dart';


class ChangeEmailBloc extends Cubit<ChangeEmailState>{
  ChangeEmailBloc(this.passwordService): super(ChangeEmailState.initial());

  PasswordService passwordService;

  Future<void> forgetPassword(Map<String, dynamic> data)async{
    emit(ChangeEmailState.loading(state.changeEmail));
    try{
      final message = await passwordService.changeEmail(data);

      emit(ChangeEmailState.success(state.changeEmail, message));
    }on ApiError catch(error){
      emit(ChangeEmailState.failed(state.changeEmail,  error.message));
    }
  }

}