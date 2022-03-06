// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/feeds_screen/feeds_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialCreatePostSuccessState){
          toastMsg(msg: 'Post Created Successfuly', states: ToastStates.Success);
          Navigator.pop(context);
        }else if(state is SocialCreatePostErrorState){
          toastMsg(msg: 'Erro While Creating The Post', states: ToastStates.Error);
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var textController = TextEditingController();
        var nowTime = DateTime.now();
        var postImage = cubit.postImage;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'New Post',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: defaultColor,
                  ),
            ),
            titleSpacing: 5,
            actions: [
              defaultTextButton(
                  label: 'Post',
                  onPress: () {
                    if (cubit.postImage == null) {
                      cubit.createPost(
                        dateTime: nowTime.toString(),
                        postText: textController.text,
                      );
                    } else {
                      cubit.uplaodpostImage(
                        dateTime: nowTime.toString(),
                        postText: textController.text,
                      );
                    }
                  },
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.blueAccent,
                      )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if(state is SocialUploadPostImageLoadingState || state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider(
                        'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Yassin Salah',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind...',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (cubit.postImage != null)
                  Stack(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: FileImage(postImage!),
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
                                cubit.removePostImage();
                              },
                              icon: Icon(
                                FeatherIcons.x,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FeatherIcons.image,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Upload Image'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
