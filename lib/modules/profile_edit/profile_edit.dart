// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialGetUserSuccessState) {
          toastMsg(
              msg: 'Profile Updated Successfuly', states: ToastStates.Success);
          Navigator.pop(context);
        } else if (state is SocialGetUserErrorState) {
          toastMsg(msg: 'Something went wrong!', states: ToastStates.Error);
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = SocialCubit.get(context).userModel;
        // var profileImage = SocialCubit.get(context).profileImage;
        var nameController = TextEditingController();
        var emailController = TextEditingController();
        var phoneController = TextEditingController();
        var bioController = TextEditingController();
        final profileImage = cubit.profileImage;
        final coverImage = cubit.coverImage;

        nameController.text = userModel!.name;
        emailController.text = userModel.email;
        phoneController.text = userModel.phone;
        bioController.text = userModel.bio;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                FeatherIcons.arrowLeft,
              ),
            ),
            title: Text('Edit Profile'),
            titleSpacing: 5,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: ConditionalBuilder(
                  condition: state is! SocialUploadLoadingState,
                  builder: (context) => defaultTextButton(
                    onPress: () {
                      if (profileImage != null && coverImage != null) {
                        cubit.uploadProfileImage(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text,
                        );
                        cubit.uplaodCoverImage(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text,
                        );
                      } else if (coverImage != null && profileImage == null) {
                        cubit.uplaodCoverImage(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text,
                        );
                      } else if (profileImage != null && coverImage == null) {
                        cubit.uploadProfileImage(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text,
                        );
                      } else if (profileImage == null && coverImage == null) {
                        cubit.updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text,
                        );
                      }
                    },
                    label: 'Save',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      height: 185,
                      child: Stack(
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                  image: coverImage == null
                                      ? CachedNetworkImageProvider(
                                          userModel.cover,
                                        )
                                      : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: IconButton(
                                  onPressed: () {
                                    cubit.getCoverImage();
                                  },
                                  icon: Icon(
                                    FeatherIcons.camera,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: CircleAvatar(
                              radius: 53,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: profileImage == null
                                        ? CachedNetworkImageProvider(
                                            userModel.image,
                                          )
                                        : FileImage(profileImage)
                                            as ImageProvider,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.getProfileImage();
                                      },
                                      icon: Icon(
                                        FeatherIcons.camera,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DefaultFormField(
                    prefix: FeatherIcons.user,
                    keyboardType: TextInputType.text,
                    label: 'Name',
                    itemController: nameController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DefaultFormField(
                    prefix: FeatherIcons.mail,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: true,
                    label: 'Email Address',
                    itemController: emailController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DefaultFormField(
                    prefix: FeatherIcons.phone,
                    keyboardType: TextInputType.phone,
                    label: 'Phone Number',
                    itemController: phoneController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DefaultFormField(
                    prefix: FeatherIcons.info,
                    keyboardType: TextInputType.phone,
                    label: 'Bio',
                    itemController: bioController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
