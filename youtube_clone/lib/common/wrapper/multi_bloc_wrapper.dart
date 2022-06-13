import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/features/dashboard/cubit/video_cubit.dart';
import 'package:youtube_clone/features/dashboard/resources/video_repository.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({ Key? key , required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>VideoCubit(videoRepository: RepositoryProvider.of<VideoRepository>(context))),
      ],
      child: child,
    );
  }
}