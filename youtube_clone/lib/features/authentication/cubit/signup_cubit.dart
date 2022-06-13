import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/common/cubits/common_state.dart';
import 'package:youtube_clone/features/authentication/resourse/user_repository.dart';

class SignUpCubit extends Cubit<CommonState> {
  SignUpCubit({required this.userRepository}) : super(CommonInitialState());

  final UserRepository userRepository;

  signUp({required email, required password}) async {
    emit(CommonLoadingState());
    final _res = await userRepository.signUpWithEmailPassword(
        email: email, password: password);
    if (_res.status) {
      emit(CommonSuccessState(data: true));
    } else {
      emit(CommonErrorState(message: _res.message));
    }
  }
}
