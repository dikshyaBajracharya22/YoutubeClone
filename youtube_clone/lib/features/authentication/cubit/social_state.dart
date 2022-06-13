part of 'social_cubit.dart';

abstract class SocialState {}

class SocialInitial extends SocialState {}

class SocialLoading extends SocialState {}

class SocialSuccess extends SocialState {}

class SocialError extends SocialState {
  final String message;
  SocialError({required this.message});
}
