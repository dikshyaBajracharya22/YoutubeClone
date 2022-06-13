import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/common/model/user.dart';

class SharedPref{
 static const String _isFirstTime="firstTime";//key
 static const String _user="user";

 static void setFirstTime(bool status)async{//OBJ=certain kam sakeypachi setfirstTime lai false garni hamro kam(OnBoardingWidget.dart)
    SharedPreferences sharedPreferencess=await SharedPreferences.getInstance();
   await sharedPreferencess.setBool(_isFirstTime, status);
  }

 static Future<bool> getFirstTime()async{
    SharedPreferences sharedPreferencess=await SharedPreferences.getInstance();
   final _res= sharedPreferencess.getBool(_isFirstTime);//res ma null vaneko kei set vaxaina tyo vaneko first timeho
   return _res ?? true;// so kei xaina vani isfirsttime = true;
  }
//facebook
  static void setUser(User user)async{//OBJ=certain kam sakeypachi setfirstTime lai false garni hamro kam(OnBoardingWidget.dart)
    SharedPreferences sharedPreferencess=await SharedPreferences.getInstance();
    final _encodedData=json.encode(user.toJson());
   await sharedPreferencess.setString(_user, _encodedData);
  }

 static Future<User?> getUser()async{
    SharedPreferences sharedPreferencess=await SharedPreferences.getInstance();
   final _res= sharedPreferencess.getString(_user);//res ma null vaneko kei set vaxaina tyo vaneko first timeho
   if(_res!=null){
     final _decodedData=Map<String, dynamic>.from(json.decode(_res));
     final _user=User.fromJson(_decodedData);
     return _user;
   }
   return null;// so kei xaina vani isfirsttime = true;
  }
 static void removeUser()async{//OBJ=certain kam sakeypachi setfirstTime lai false garni hamro kam(OnBoardingWidget.dart)
    SharedPreferences sharedPreferencess=await SharedPreferences.getInstance();
   await sharedPreferencess.remove(_user);
  } 

}