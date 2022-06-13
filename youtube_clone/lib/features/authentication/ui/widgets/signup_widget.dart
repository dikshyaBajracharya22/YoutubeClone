import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_clone/common/constants/theme.dart';
import 'package:youtube_clone/common/cubits/common_state.dart';
import 'package:youtube_clone/common/utils/snackbar_utils.dart';
import 'package:youtube_clone/features/authentication/cubit/signup_cubit.dart';
import 'package:youtube_clone/features/authentication/ui/pages/login_page.dart';


import '../../../../common/widgets/buttons/custom_rounded_button.dart';
import '../../../../common/widgets/text_fields/custom_textfield.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
      final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    bool _isLoading = false;

    return BlocListener<SignUpCubit, CommonState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is CommonLoadingState){
          setState(() {
            _isLoading=true;
          });
        }else{
          setState(() {
            _isLoading=false;
          });

        }
        if(state is CommonSuccessState){
           SnackbarUtils.showSnackBar(context: context, message: "Signed Up Succesfully");
           Navigator.of(context).pop();

        }else if(state is CommonErrorState){
          SnackbarUtils.showSnackBar(context: context, message: state.message);
        }
      },
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: CustomTheme.primarycolor,
            ),
            body: Container(
              child: Form(
                key: _formkey,
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
                        validator: (val){                     
                           final _isValid= EmailValidator.validate(val ?? "");
                           if(_isValid){
                             return null;
                           }else{
                             return "Enter valid Email address";
                           }
                        
                        },
                      ),
                      CustomTextField(
                        obscure: true,
                        title: "Password",
                        hintText: "Enter your password",
                        controller: _passwordController,
                        validator: (val){
                          if(val==null || val.isEmpty){
                            return "Password cannot be empty";
                          }else if(val.length<4){
                            return "Password must be atleast 4 character long";
                          }else{
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        obscure: true,
                        title: "Confirm Password",
                        hintText: "Enter your password again",
                        controller: _confirmPasswordController,
                         validator: (val){
                          if(val==null || val.isEmpty){
                            return "Password cannot be empty";
                          }else if(val.length<4){
                            return "Password must be atleast 4 character long";
                          }else if(val != _passwordController.text){
                            return "Password doesnot match";
                          }
                          
                          else{
                            return null;
                          }
                        },
                      ),
                      CustomRoundedButton(
                        title: "SIGNUP",
                        onPressed: () {
                          if(_formkey.currentState!.validate()){
                            context.read<SignUpCubit>().signUp(email: _emailController.text, password: _passwordController.text);
                          } 
                        },
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                            text: "Already have an account?",
                            style: _textTheme.bodyText2,
                            children: [
                              TextSpan(
                                  text: " Login",
                                  style: _textTheme.bodyText2!.copyWith(
                                      color: CustomTheme.primarycolor,
                                      fontWeight: FontWeight.w600),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).pop();
                                    }),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
