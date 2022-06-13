import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_clone/common/constants/assets.dart';
import 'package:youtube_clone/features/dashboard/ui/screens/dashboard_page.dart';
import 'package:youtube_clone/features/onboarding/ui/screens/on_boarding_page.dart';
import 'package:youtube_clone/features/splash/cubit/startup_cubit.dart';

import '../../../authentication/ui/pages/login_page.dart';

class SplashWidgets extends StatefulWidget {
  const SplashWidgets({Key? key}) : super(key: key);

  @override
  State<SplashWidgets> createState() => _SplashWidgetsState();
}

class _SplashWidgetsState extends State<SplashWidgets> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<StartupCubit>().fetchStartupData();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return BlocListener<StartupCubit, StartupState>(
      listener: (context, state) {
        if (state is StartUpSuccess) {
          if (state.isFirstTime) {// state bata firsttime true huda 
            //On first Time
            Navigator.of(context).pushReplacement(PageTransition(
                child: OnBoardingPage(), type: PageTransitionType.fade));
          } else {
            if (state.isLoggedIn) {
              //Send to Dashboard/home

              Navigator.of(context).pushAndRemoveUntil(PageTransition(child: DashboardPage(), type: PageTransitionType.fade), (route) => false);
            } else {//true haina vaney/ isFirstTime=false huda
              //if set/get vaisakyaxa ==state bata firsttime false huda 
              //Send to Login Screen
          Navigator.of(context).pushReplacement(PageTransition(child: LoginPage(), type: PageTransitionType.fade));

            }
          }
        }
        // TODO: implement listener
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Assets.youtube,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              SizedBox(height: 20),
              Text(
                "Youtube Clone",
                style:
                    _textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
