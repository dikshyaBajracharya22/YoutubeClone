import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_clone/common/constants/assets.dart';
import 'package:youtube_clone/common/utils/shared_pref.dart';

import '../../authentication/ui/pages/login_page.dart';
// Package Introduction SCREEN
class OnBoardingWidgets extends StatefulWidget {
  const OnBoardingWidgets({ Key? key }) : super(key: key);

  @override
  State<OnBoardingWidgets> createState() => _OnBoardingWidgetsState();
}

class _OnBoardingWidgetsState extends State<OnBoardingWidgets> {
  final List<PageViewModel> _items=[
    PageViewModel(
  title: "Title of first page",
  body: "Here you can write the description of the page, to explain someting...",
  image: Center(
    child: SvgPicture.asset(Assets.video1, height: 175.0),
  ),
),
 PageViewModel(
  title: "Title of second page",
  body: "Here you can write the description of the page, to explain someting...",
  image: Center(
    child: SvgPicture.asset(Assets.intro, height: 175.0),
  ),
),
 PageViewModel(
  title: "Title of third page",
  body: "Here you can write the description of the page, to explain someting...",
  image: Center(
    child: SvgPicture.asset(Assets.video2, height: 175.0),
  ),
),
  ];
  @override
  Widget build(BuildContext context) {
    final _theme=Theme.of(context);
    final _textTheme=_theme.textTheme;
    return Scaffold(
      body: IntroductionScreen(
  pages: _items,
  onDone: () {
    // When done button is pressed
    //SharedPref
    //last ma boardig screen sakepachi done garda set hunaparyo value wich will mean it is not first time anymore
    SharedPref.setFirstTime(false);
    Navigator.of(context).pushReplacement(PageTransition(child: LoginPage(), type: PageTransitionType.fade));

  },
  showBackButton: true,
  showSkipButton: false,
  back: const Icon(Icons.keyboard_arrow_left_rounded),
  next:  Icon(Icons.keyboard_arrow_right_rounded),
  done:  Icon(Icons.done_rounded),
),
      
    );
  }
}