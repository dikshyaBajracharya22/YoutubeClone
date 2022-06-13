import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_clone/common/constants/assets.dart';
import 'package:youtube_clone/common/constants/theme.dart';
import 'package:youtube_clone/common/utils/snackbar_utils.dart';
import 'package:youtube_clone/common/widgets/buttons/custom_rounded_button.dart';
import 'package:youtube_clone/common/widgets/text_fields/custom_textfield.dart';
import 'package:youtube_clone/features/authentication/cubit/login_cubit.dart';
import 'package:youtube_clone/features/authentication/cubit/social_cubit.dart';
import 'package:youtube_clone/features/authentication/ui/pages/signup_page.dart';

import '../../../dashboard/ui/screens/dashboard_page.dart';

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({Key? key}) : super(key: key);

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is LoginLoading) {
              setState(() {
                _isLoading = true;
              });
            } else {
              setState(() {
                _isLoading = false;
              });
            }
            if (state is LoginSuccess) {
              Navigator.of(context).pushAndRemoveUntil(PageTransition(child: DashboardPage(), type: PageTransitionType.fade), (route) => false);

              SnackbarUtils.showSnackBar(
                  context: context, message: "Logged in Succesfully");
            } else if (state is LoginError) {
              SnackbarUtils.showSnackBar(
                  context: context, message: state.message);
            }
          },
        ),
       BlocListener<SocialCubit, SocialState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SocialLoading) {
            setState(() {
              _isLoading = true;
            });
          } else {
            setState(() {
              _isLoading = false;
            });
          }
          if (state is SocialSuccess) {
              Navigator.of(context).pushAndRemoveUntil(PageTransition(child: DashboardPage(), type: PageTransitionType.fade), (route) => false);

            SnackbarUtils.showSnackBar(
                context: context, message: "Logged in Succesfully");
          } else if (state is SocialError) {
            SnackbarUtils.showSnackBar(
                context: context, message: state.message);
          }
        },)
      ],
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CustomTheme.primarycolor,
          ),
          body: Container(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: CustomTheme.horixontalPadding,
            ),
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  title: "Email Address",
                  hintText: "Enter Email Address",
                  controller: _emailController,
                ),
                CustomTextField(
                  obscure: true,
                  title: "Password",
                  hintText: "Enter your password",
                  controller: _passwordController,
                ),
                CustomRoundedButton(
                  title: "LOGIN",
                  onPressed: () {
                    context.read<LoginCubit>().SiginWithEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                  },
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                      text: "Don't have an account?",
                      style: _textTheme.bodyText2,
                      children: [
                        TextSpan(
                            text: " SignUp",
                            style: _textTheme.bodyText2!.copyWith(
                                color: CustomTheme.primarycolor,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(PageTransition(
                                    child: SignUpPage(),
                                    type: PageTransitionType.fade));
                              }),
                      ]),
                ),
                SizedBox(height: 20),
                Text("or SignIn with"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          context.read<SocialCubit>().loginWithGoogle();
                        },
                        icon: Image.asset(
                          Assets.google,
                          height: 50,
                          width: 50,
                        )),
                    IconButton(
                        onPressed: () {
                          context.read<SocialCubit>().loginWithFacebook();
                        },
                        icon: Image.asset(
                          Assets.facebook,
                          height: 50,
                          width: 50,
                        ))
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
