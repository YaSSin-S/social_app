// ignore_for_file: avoid_print, unnecessary_import, unused_import

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/users_model/users_model.dart';
import 'package:social_app/modules/register_screen/register_cubit/register_states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialLoadingRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(SocialSuccessRegisterState());
      userCreate(
        email: email,
        phone: phone,
        name: name,
        uID: value.user!.uid,
        image:
            'https://image.freepik.com/free-vector/portrait-cat-with-bow-tie-glasses-hipster-with-look-isolated-vector-illustration_1284-1931.jpg',
        cover:
            'https://image.freepik.com/free-photo/gold-bengal-cat-white-space_155003-12732.jpg',
        bio: 'test test',
      );
    }).catchError((error) {
      emit(SocialErrorRegisterState(error.toString()));
    });
  }

  UsersModel? model;

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uID,
    required String cover,
    required String image,
    required String bio,
    bool? isEmailVerified,
  }) {
    model = UsersModel(
      name: name,
      email: email,
      phone: phone,
      uID: uID,
      cover: 'https://image.freepik.com/free-photo/gold-bengal-cat-white-space_155003-12732.jpg',
      image: 'https://image.freepik.com/free-vector/portrait-cat-with-bow-tie-glasses-hipster-with-look-isolated-vector-illustration_1284-1931.jpg',
      bio: 'test test',
      // isEmailVerified: isEmailVerified = false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .set(model!.toMap())
        .then((value) {
      emit(SocialSuccessCreateState(uID));
    }).catchError((error) {
      print(error.toString());
      emit(SocialErrorCreateState(error.toString()));
    });
  }
}
