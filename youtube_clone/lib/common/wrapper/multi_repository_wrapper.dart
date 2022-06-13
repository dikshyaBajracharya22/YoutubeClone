import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/features/authentication/resourse/user_repository.dart';
import 'package:youtube_clone/features/dashboard/resources/video_repository.dart';
import 'package:youtube_clone/features/splash/resourse/startup_repository.dart';

class MultiRepositoryWrapper extends StatelessWidget {
  final Widget child;
  const MultiRepositoryWrapper({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => StartUpRepository()),
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => VideoRepository()),
      ],
      child: child,
    );
  }
}
