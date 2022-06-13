import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/features/authentication/resourse/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.userRepository}) : super(LoginInitial());

  final UserRepository userRepository;


  SiginWithEmailPassword({required String email, required String password}) async{
      emit(LoginLoading());
      final _res=await UserRepository().loginWithEmailPassword(email: email, password: password);

    if(_res.status){
      emit(LoginSuccess());
    }else{
      emit(LoginError(message: _res.message));
    }
  }
}
