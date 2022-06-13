import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_clone/common/constants/theme.dart';
import 'package:youtube_clone/common/widgets/buttons/custom_rounded_button.dart';
import 'package:youtube_clone/features/authentication/resourse/user_repository.dart';
import 'package:youtube_clone/features/authentication/ui/pages/login_page.dart';

showLogoutDialogBox(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return LogoutDialogBox();
      });
}

class LogoutDialogBox extends StatelessWidget {
  const LogoutDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text("Logout")),
          IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: Icon(Icons.close))
        ],
      ),
      titlePadding: EdgeInsets.only(top: 4, left: CustomTheme.horixontalPadding),
      content: Text("Are you sure you want to logout?"),
      actionsAlignment: MainAxisAlignment.center,

      actions: [
        CustomRoundedButton(title: "Confirm", onPressed: (){
          RepositoryProvider.of<UserRepository>(context).logout();
          Navigator.of(context).pushAndRemoveUntil(PageTransition(child:LoginPage() , type: PageTransitionType.fade), (route) => false);
        },),
      ],
    );
  }
}
