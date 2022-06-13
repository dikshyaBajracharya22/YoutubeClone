import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/features/authentication/resourse/user_repository.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit({required this.userRepository}) : super(SocialInitial());
  final UserRepository userRepository;

  loginWithGoogle() async{
    emit(SocialLoading());
    final res=await userRepository.loginWithGoogle();
    if(res.status){//status=DataResponse.dart / user_repo.dart
      emit(SocialSuccess());
    }else{
      emit(SocialError(message: res.message));
    }
  }
   loginWithFacebook() async{
    emit(SocialLoading());
    final res=await userRepository.loginWithFacebook();
    if(res.status){//status=DataResponse.dart / user_repo.dart
      emit(SocialSuccess());
    }else{
      emit(SocialError(message: res.message));
    }
  }
}
