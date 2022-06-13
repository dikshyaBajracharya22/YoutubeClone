import 'package:bloc/bloc.dart';
import 'package:youtube_clone/common/utils/shared_pref.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit() : super(StartupInitial());

  fetchStartupData() async {
    emit(Startuploading());
    final _isfirstTime=await SharedPref.getFirstTime();
    final _user=await SharedPref.getUser();

    await Future.delayed(Duration(seconds: 2));
    final _isLoggedIn=_user!=null;
    emit(StartUpSuccess(isFirstTime: _isfirstTime, isLoggedIn: _isLoggedIn));//_isfirstTime pani true ki false huncha 
  }
}
