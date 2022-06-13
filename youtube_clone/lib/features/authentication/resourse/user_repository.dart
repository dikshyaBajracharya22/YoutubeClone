import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youtube_clone/common/model/data_response.dart';
import 'package:youtube_clone/common/model/user.dart' as u;
import 'package:youtube_clone/common/utils/shared_pref.dart';

class UserRepository {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  ValueNotifier<u.User?> user=ValueNotifier(null);

 
//google
  Future<DataResponse> loginWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
      await _googleSignIn.signOut();
      final _googleUser = await _googleSignIn.signIn();
      if(_googleUser!=null){
        user.value=u.User(email:_googleUser.email, id: "", name: _googleUser.displayName ?? "");
        SharedPref.setUser(user.value!);
        _isLoggedIn=true;
        return DataResponse.success(data: true);

      }else{
        return DataResponse.error(message: "Unale to login with google");
      }
      
      // print(_googleUser?.email);
      // print(_googleUser?.photoUrl);

    } catch (e) {
      return DataResponse.error(message: e.toString());
    }
  }

//Login
  Future<DataResponse> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signOut();
      //self
      final _res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
user.value=u.User(email:_res.user?.email ?? "", id: "", name:_res.user?.displayName ?? "");
        SharedPref.setUser(user.value!);
        _isLoggedIn=true;
      print(_res.user?.email);

      return DataResponse.success(data: true);
    } catch (e) {
      return DataResponse.error(message: e.toString());
    }
  }

//signup
  Future<DataResponse> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signOut();
      //self
      final _res = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print(_res.user?.email);

      return DataResponse.success(data: true);
    } catch (e) {
      return DataResponse.error(message: e.toString());
    }
  }

  //facebook
  Future<DataResponse> loginWithFacebook() async {
    try {
      await fb.FacebookAuth.instance.logOut();
      final fb.LoginResult result = await fb.FacebookAuth.instance
          .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
      if (result.status == fb.LoginStatus.success) {
        // you are logged
          final userData = await fb.FacebookAuth.i.getUserData(
        fields: "name,email,picture.width(200),birthday,friends,gender,link",
    );
         user.value=u.User(email:userData["email"], id: "", name: userData["email"]);
        SharedPref.setUser(user.value!);
        _isLoggedIn=true;
        return DataResponse.success(data: true);
      } else {
       return DataResponse.error(message: result.message ?? "Unable to login with facebook");
      }

    } catch (e) {
      return DataResponse.error(message: e.toString());
    }
  }
   Future<void> logout() async{
      await FirebaseAuth.instance.signOut();
      SharedPref.removeUser();
      _isLoggedIn=false;
      user.value=null;

  } 
}
