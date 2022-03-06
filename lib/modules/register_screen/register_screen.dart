// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/modules/register_screen/register_cubit/register_cubit.dart';
import 'package:social_app/modules/register_screen/register_cubit/register_states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  bool isPassword = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialSuccessCreateState) {
            toastMsg(msg: 'Registered Successfully', states: ToastStates.Success);
            CacheHelper.saveData(
              key: 'uId',
              value: state.uID,
            ).then((value) {
              navigateNoReturn(context, SocialLayout());
            });
          }
        },
        builder: (context, state) {
          SocialRegisterCubit cubit = SocialRegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Register to communicate with friends.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            DefaultFormField(
                              keyboardType: TextInputType.name,
                              label: 'Name',
                              prefix: Icons.person,
                              itemController: nameController,
                              onSubmitAction: TextInputAction.next,
                              mustValidate: true,
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
                                  cubit.userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    name: nameController.text,
                                  );
                                }
                              },
                              onSubmitAction: TextInputAction.next,
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
                            SizedBox(
                              height: 30,
                            ),
                            DefaultFormField(
                              keyboardType: TextInputType.phone,
                              label: 'Phone Number',
                              prefix: Icons.phone,
                              itemController: phoneController,
                              onSubmitAction: TextInputAction.next,
                              mustValidate: true,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ConditionalBuilder(
                              condition: state is! SocialLoadingRegisterState,
                              builder: (context) => DefaultButton(
                                label: 'Register',
                                fontSize: 18,
                                borderRadius: 30,
                                onPress: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                              ),
                              fallback: (context) =>
                                  CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      ),
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
