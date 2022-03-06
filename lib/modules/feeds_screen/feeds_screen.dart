// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/shared/components/constants.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8),
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      Image(
                        width: double.infinity,
                        image: CachedNetworkImageProvider(
                          'https://image.freepik.com/free-photo/photo-stupefied-dark-haired-girl-with-bated-breath-stares-with-bugged-eyes-being-shocked-by-high-prices_273609-17559.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      // Image.network('https://c.tenor.com/DloYoakaD_UAAAAC/backhand-index-pointing-right-joypixels.gif'),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          'COMMUNICATE\nWITH\nYOUR\nFRIENDS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 2.5,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => postBuilder(
                    context,
                    cubit.posts[index],
                    index,
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }
}

Widget postBuilder(
  context,
  PostsModel model,
  index,
) =>
    Card(
      margin: EdgeInsets.all(8),
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
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
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 17,
                          ),
                        ],
                      ),
                      Text(
                        model.dateTime,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.8,
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FeatherIcons.moreHorizontal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Wrap(
              children: [
                Text(
                  model.postText,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   child: Wrap(
            //     spacing: 5,
            //     runSpacing: 18,
            //     children: [
            //       MaterialButton(onPressed: (){},
            //         minWidth: 1,
            //       child: Text('#flutter'),
            //       ),
            //       TextButton(
            //         onPressed: () {},
            //         child: Text(
            //           '#flutter',
            //           style: TextStyle(
            //             fontSize: 18,
            //             color: defaultColor,
            //             height: 0.1,
            //           ),
            //         ),
            //       ),
            //       InkWell(
            //         child: Text(
            //           '#software',
            //           style: TextStyle(
            //             fontSize: 18,
            //             color: defaultColor,
            //             height: 0.1,
            //           ),
            //         ),
            //         onTap: () {
            //           navigateTo(context, ChatScreen());
            //         },
            //       ),
            //       InkWell(
            //         child: Text(
            //           '#software_development',
            //           style: TextStyle(
            //             fontSize: 18,
            //             color: defaultColor,
            //             height: 0.1,
            //           ),
            //         ),
            //         onTap: () {
            //           navigateTo(context, ChatScreen());
            //         },
            //       ),
            //       InkWell(
            //         child: Text(
            //           '#mobile_development',
            //           style: TextStyle(
            //             fontSize: 18,
            //             color: defaultColor,
            //             height: 0.1,
            //           ),
            //         ),
            //         onTap: () {
            //           navigateTo(context, ChatScreen());
            //         },
            //       ),
            //       InkWell(
            //         child: Text(
            //           '#technology',
            //           style: TextStyle(
            //             fontSize: 18,
            //             color: defaultColor,
            //             height: 0.1,
            //           ),
            //         ),
            //         onTap: () {
            //           navigateTo(context, ChatScreen());
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            if (model.postImage != '')
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        model.postImage,
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(5),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: 5.0,
                      end: 5.0,
                      start: 5.0,
                      top: 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FeatherIcons.heart,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${SocialCubit.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    commentPopup(
                      context,
                      model,
                      index,
                    );
                  },
                  borderRadius: BorderRadius.circular(5),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          FeatherIcons.messageSquare,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${SocialCubit.get(context).comments[index]} Comments',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16,
                              ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 0.25,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                commentPopup(context, model, index);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: CachedNetworkImageProvider(
                        SocialCubit.get(context).userModel!.image,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Write a comment ...'),
                    Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        SocialCubit.get(context)
                            .postLike(SocialCubit.get(context).postsId[index]);
                      },
                      radius: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Icon(
                              FeatherIcons.heart,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Like',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontSize: 14,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget commentBuilder(context, PostsModel model) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider(
            model.image,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(model.dateTime,
                    style: Theme.of(context).textTheme.caption),
                SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: [
                    Text(
                      'test',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );

void commentPopup(context, PostsModel model, index) {
  var commentController = TextEditingController();
  var cubit = SocialCubit.get(context);
  showDialog(
    context: context,
    builder: (context) => Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    flex: 10,
                    child: Text(
                      'Comments',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      FeatherIcons.x,
                    ),
                    highlightColor: Colors.transparent,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: defaultColor,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(8),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) =>
                      commentBuilder(context, model),
                  itemCount: cubit.comments.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        scrollPhysics: BouncingScrollPhysics(),
                        controller: commentController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Write a comment here',
                          border: InputBorder.none,
                        ),
                        // onFieldSubmitted: (){},
                      ),
                    ),
                    // Spacer(),
                    CircleAvatar(
                      backgroundColor: defaultColor,
                      child: IconButton(
                        onPressed: () {
                          cubit.makeComment(
                              cubit.postsId[index], commentController.text);
                        },
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          FeatherIcons.send,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
