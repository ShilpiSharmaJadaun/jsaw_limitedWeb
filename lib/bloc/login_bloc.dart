import 'package:bloc/bloc.dart';
import '../error/api_error.dart';
import '../service/login_service.dart';
import '../state/login_state.dart';

class LoginPageBloc extends Cubit<LoginState>{
  LoginPageBloc(this.loginService): super(LoginState.initial());

  final LoginService loginService;

  void logIn(String userCode, String password) async{
    // _validate();
    var form = state.loginModel;
    emit(LoginState.loading(form));
    try{
      final details = await loginService.logIn(userCode, password);
      emit(LoginState.success(form));
    }on ApiError catch(e){
      emit(LoginState.failed(form, e.message));
    }
  }

}

