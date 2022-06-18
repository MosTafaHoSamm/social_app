import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social3/Models/post_model.dart';
import 'package:social3/Models/register_model.dart';
import 'package:social3/shared/cubit/general_states.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/general_cubit.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
import '../login_screen/login_screen.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel=GeneralCubit.get(context).registerModel;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://img.freepik.com/free-photo/cheerful-positive-young-european-woman-with-dark-hair-broad-shining-smile-points-with-thumb-aside_273609-18325.jpg?t=st=1646179817~exp=1646180417~hmac=12d98c89406110ceb968cd2bf6b4456accc98014eb026958d591e42fa4f80a27&w=740'))),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(bottom: 4.0, end: 4),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'communicate and enjoy !',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'mostafafont',
                                  fontSize: 10),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    FirebaseMessaging.instance.subscribeToTopic('announcements');

                  },
                  child: Text('subscribe')),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return buildFeedsItem(
                      context,GeneralCubit.get(context).posts[index] ,index
                  );
                },
                itemCount: GeneralCubit.get(context).posts.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 2,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildFeedsItem(
  context,
  PostModel model,
     index


 ) {
  return Card(
    elevation: 6,
    margin: EdgeInsets.all(8),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${model.name}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.check_circle_rounded,
                        color: defaultColor,
                        size: 14,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${model.date}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.More_Circle))
            ],
          ),
          divider(),
          SizedBox(
            height: 8,
          ),
          Text(
              '${model.content}',
              maxLines: 5,
              style: TextStyle(
                fontSize: 13,
                height: 1.3,
              )),
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            width: double.infinity,
            child: Wrap(
              children: [
                Container(
                  height: 20,
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                    child: Text(
                      '# mostafa Atia',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.deepOrange),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      child: Text(
                        '# flutter_development',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.deepOrange),
                      )),
                ),
              ],
            ),
          ),
           if(model.postImage!='')
           Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage('${model.postImage}'),
            )),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {

                  },
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 18,
                        color: defaultColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${GeneralCubit.get(context).likes[index]}',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        IconBroken.Chat,
                        size: 18,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '600 comments',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          divider(),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 12,
                        backgroundImage:
                            NetworkImage('${model.image}'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  GeneralCubit.get(context).likePost(postId:GeneralCubit.get(context).postIds[index] );
                },
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 18,
                      color: defaultColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      IconBroken.Upload,
                      size: 18,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'share',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}
