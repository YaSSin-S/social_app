// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post_screen/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: true,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: TextStyle(
                  color: defaultColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FeatherIcons.search,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FeatherIcons.bell,
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(FeatherIcons.logOut),
                // ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    FeatherIcons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FeatherIcons.messageCircle,
                  ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FeatherIcons.plus,
                  ),
                  label: 'Add Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FeatherIcons.mapPin,
                  ),
                  label: 'Location',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FeatherIcons.settings,
                  ),
                  label: 'Settings',
                ),
                // Icon(
                //   FeatherIcons.home,
                // ),
                // Icon(
                //   FeatherIcons.messageCircle,
                // ),
                // Icon(
                //   FeatherIcons.plus,
                // ),
                // Icon(
                //   FeatherIcons.map,
                // ),
                // Icon(
                //   FeatherIcons.settings,
                // ),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeButtonNav(index);
              },
            ),
          ),
          fallback: (context) => Center(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        );
      },
    );
  }
}
