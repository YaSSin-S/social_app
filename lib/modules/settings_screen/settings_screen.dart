// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/users_model/users_model.dart';
import 'package:social_app/modules/profile_edit/profile_edit.dart';
import 'package:social_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Column(
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
                            image: CachedNetworkImageProvider(
                              userModel!.cover,
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: CircleAvatar(
                        radius: 53,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: CachedNetworkImageProvider(
                            userModel.image,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              userModel.name,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              userModel.bio,
              style: Theme.of(context).textTheme.caption,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: OutlinedButton(
                onPressed: () {
                  navigateTo(context, ProfileEditScreen());
                },
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FeatherIcons.edit,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Edit Profile'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
