// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model/message_model.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/models/users_model/users_model.dart';
import 'package:social_app/modules/chats_screen/chat_screen.dart';
import 'package:social_app/modules/feeds_screen/feeds_screen.dart';
import 'package:social_app/modules/new_post_screen/new_post_screen.dart';
import 'package:social_app/modules/settings_screen/settings_screen.dart';
import 'package:social_app/modules/users_screen/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UsersModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uID).get().then((value) {
      userModel = UsersModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<String> titles = [
    'Home',
    'Chats',
    'New Post',
    'Location',
    'Settings',
  ];
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  void changeButtonNav(index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeNavState());
    }
  }

  File? profileImage;
  var imagePicker = ImagePicker();

  Future<void> getProfileImage() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImageSuccessState());
    } else {
      print('No Image Selected.');
      emit(SocialProfileImageErrorState());
    }
  }

  File? coverImage;
  var coverImagePicker = ImagePicker();

  Future<void> getCoverImage() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialProfileImageSuccessState());
    } else {
      print('No Image Selected.');
      emit(SocialProfileImageErrorState());
    }
  }

  firebase_storage.FirebaseStorage fireStorage =
      firebase_storage.FirebaseStorage.instance;

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(SocialUploadLoadingState());

    fireStorage
        .ref()
        .child(
            'users/profile-images/__${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uplaodCoverImage({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(SocialUploadLoadingState());

    fireStorage
        .ref()
        .child(
            'users/cover-images/__${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUser({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null) {
  //     uplaodCoverImage();
  //   } else {
  //     model = UsersModel(
  //       name: name,
  //       email: model!.email,
  //       phone: phone,
  //       uID: model!.uID,
  //       cover: model!.cover,
  //       image: model!.image,
  //       bio: bio,
  //     );
  //
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uID)
  //         .update(model!.toMap())
  //         .then((value) {
  //       getUserData();
  //     }).catchError((error) {});
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(SocialUploadLoadingState());

    userModel = UsersModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      uID: userModel!.uID,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      bio: bio,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .update(userModel!.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {});
  }

  File? postImage;

  Future<void> getPostImage() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialUploadPostImageSuccessState());
    } else {
      print('No Image Selected.');
      emit(SocialUploadPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uplaodpostImage({
    required String dateTime,
    required String postText,
  }) {
    emit(SocialUploadPostImageLoadingState());
    fireStorage
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          postText: postText,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  // PostsModel? postModel;

  void createPost({
    required String dateTime,
    required String postText,
    String? image,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostsModel postModel = PostsModel(
        name: userModel!.name,
        uID: userModel!.uID,
        dateTime: dateTime,
        postText: postText,
        image: userModel!.image,
        postImage: postImage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
      // print(postModel.uID);
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostsModel> posts = [];
  List<String> postsId =
      []; // to store each document's id with corrosponding post
  List<int> likes = []; // to store number of likes for each post
  List<int> comments = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
        }).catchError((error) {});
        element.reference.collection('likes').get().then((value) {
          likes.add(
            value.docs.length,
          ); // looping on all documents in the likes subcollection to get the number of the likes
          posts.add(
            PostsModel.fromJson(
              element.data(),
            ),
          ); // adding each post's data to the list
          postsId.add(element
              .id); // adding each post's id in the list to have the same index as the posts list
          emit(SocialGetLikesNumberSuccessState());
        }).catchError((error) {
          emit(SocialGetLikesNumberErrorState(error.toString()));
        });
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  bool like = true;

  void postLike(String postsId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId)
        .collection('likes')
        .doc(userModel!.uID)
        .set({
      'like': like,
    }).then((value) {
      emit(SocialPostLikeSuccessState());
    }).catchError((error) {
      emit(SocialPostLikeErrorState(error.toString()));
      print(error.toString());
    });
  }

  void makeComment(String postsId, String comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId)
        .collection('comments')
        .doc(userModel!.uID)
        .set({
      'comment': comment,
    }).then((value) {
      emit(SocialPostMakeCommentSuccessState());
    }).catchError((error) {
      emit(SocialPostMakeCommentErrorState(error.toString()));
    });
  }

  // List<PostsModel> postComments = [];
  //
  // void getComments(String postsId) {
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postsId)
  //       .collection('comments')
  //       .get()
  //       .then((value) {
  //         value.docs.forEach((element) {
  //           postComments.add(
  //             PostsModel.fromJson(
  //               element.data(),
  //             ),
  //           ); //
  //         });
  //         emit(SocialPostGetCommentSuccessState());
  //   })
  //       .catchError((error) {
  //         emit(SocialPostGetCommentErrorState(error.toString()));
  //   });
  // }

  List<UsersModel> users = [];

  void getAllUsers() {
    emit(SocialGetAllUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uID) {
            users.add(UsersModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
        print(error.toString());
      });
    }
  }

  void sendMessage(
    String textMessage,
    String dateTime,
    String receiverId,
  ) {
    MessagesModel model = MessagesModel(
      textMessage: textMessage,
      dateTime: dateTime,
      senderId: userModel!.uID,
      receiverId: receiverId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uID)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessagesModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uID)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('date_time')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessagesModel.fromJson(element.data()));
        print(element.data());
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}
