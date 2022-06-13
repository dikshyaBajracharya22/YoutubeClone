import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/features/authentication/cubit/login_cubit.dart';
import 'package:youtube_clone/features/authentication/cubit/social_cubit.dart';
import 'package:youtube_clone/features/authentication/resourse/user_repository.dart';
import 'package:youtube_clone/features/authentication/ui/widgets/login_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context)),
        ),
      ],
      child: LoginWidgets(),
    );
  }
}
