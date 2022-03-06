// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/modules/login_screen/login_cubit/login_cubit.dart';
import 'package:social_app/modules/login_screen/login_cubit/login_states.dart';
import 'package:social_app/modules/register_screen/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPassword = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialErrorState) {
            toastMsg(msg: 'Error Logging IN', states: ToastStates.Error,);
          }
          if (state is SocialSuccessState) {
            toastMsg(msg: 'Logged In Successfully', states: ToastStates.Success,);
            CacheHelper.saveData(
              key: 'uId',
              value: state.uID,
            ).then((value) {
              if (value) {
                navigateNoReturn(context, SocialLayout());
              }
            navigateNoReturn(context, SocialLayout());
          });
        }
          },
        builder: (context, state) {
          SocialLoginCubit cubit = SocialLoginCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.indigo,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'IN-GYM',
                                style: GoogleFonts.bangers(
                                  fontSize: 100,
                                  color: Colors.white,
                                ),
                                // TextStyle(
                                //   fontFamily: 'InstagramFont',
                                //   fontWeight: FontWeight.bold,
                                //   fontSize: 50,
                                //   color: Colors.white,
                                // ),  //Instagram Font
                              ),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(
                            seconds: 2,
                          ),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Login to communicate with friends.',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              DefaultFormField(
                                keyboardType: TextInputType.emailAddress,
                                label: 'Email Address',
                                prefix: Icons.email_outlined,
                                itemController: emailController,
                                onSubmitAction: TextInputAction.next,
                                mustValidate: true,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              DefaultFormField(
                                keyboardType: TextInputType.visiblePassword,
                                label: 'Password',
                                prefix: Icons.lock_outline,
                                itemController: passwordController,
                                onSubmit: () {
                                  if (formKey.currentState!.validate()) {
                                    // cubit.userLogin(
                                    //   email: emailController.text,
                                    //   password: passwordController.text,
                                    // );
                                  }
                                },
                                mustValidate: true,
                                isPassword: isPassword,
                                suffix: isPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                onSuffixPress: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  defaultTextButton(
                                    onPress: () {},
                                    label: 'Forgot Password ?',
                                  ),
                                ],
                              ),
                              ConditionalBuilder(
                                condition: state is! SocialLoadingState,
                                builder: (context) => DefaultButton(
                                  label: 'Login',
                                  fontSize: 18,
                                  borderRadius: 30,
                                  onPress: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                ),
                                fallback: (context) =>
                                    CircularProgressIndicator(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t have and account?'),
                                  defaultTextButton(
                                    onPress: () {
                                      navigateTo(
                                        context,
                                        RegisterScreen(),
                                      );
                                    },
                                    label: 'Register',
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
