part of 'startup_cubit.dart';

abstract class StartupState {}

class StartupInitial extends StartupState {}

class Startuploading extends StartupState{}

class StartUpSuccess extends StartupState{
  final bool isFirstTime;
  final bool isLoggedIn;

  StartUpSuccess({required this.isFirstTime, required this.isLoggedIn});
}
