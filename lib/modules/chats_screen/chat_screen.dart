// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model/message_model.dart';
import 'package:social_app/models/users_model/users_model.dart';
import 'package:social_app/modules/chats_screen/chat_messages/chat_messages.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.users.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                chatBuilder(context, cubit.users[index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            itemCount: cubit.users.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator.adaptive()),
        );
      },
    );
  }

  Widget chatBuilder(context, UsersModel model) => InkWell(
        onTap: () {
          navigateTo(context, ChatMessagesScreen(usersModel: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(
                  model.image,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        model.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'model.dateTime',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.8,
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
