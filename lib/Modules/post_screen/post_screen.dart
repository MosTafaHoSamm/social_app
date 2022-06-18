import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social3/shared/cubit/general_cubit.dart';
import 'package:social3/shared/cubit/general_states.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class PostsScreen extends StatelessWidget {
  var contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralStates>(
        listener: (context,state)=>{},
        builder: (context, state) {
      return Scaffold(
        appBar: defaultAppBar(
            context: context,
            actions: [
              TextButton(
                  onPressed: () {
                    if (GeneralCubit.get(context).postImage!=null)
                      {
                        GeneralCubit.get(context).uploadPostImage(content: contentController.text, dateTime: DateTime.now().toString());
                        GeneralCubit.get(context).getPosts();
                      }
                        GeneralCubit.get(context).createPost(
                        content: contentController.text,
                        dateTime: DateTime.now().toString());
                    GeneralCubit.get(context).getPosts();

                  },
                  child: Text(
                    'Post',
                    style: TextStyle(fontSize: 16),
                  )),
            ],
            text: 'Add Post',
            icon: IconBroken.Arrow___Left_2),
        body: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/portrait-successful-man-having-stubble-posing-with-broad-smile-keeping-arms-folded_171337-1267.jpg?w=740'),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Mostafa Hosam',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 12),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: contentController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'what do you think ?'),
                ),

              ),
            ),
            if (GeneralCubit.get(context).postImage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Stack(
alignment: AlignmentDirectional.topEnd,
                  children: [
                     Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(GeneralCubit.get(context).postImage))),
                    ),
                    IconButton(onPressed: (){GeneralCubit.get(context).removePost();}, icon: Icon(IconBroken.Close_Square,size: 26,)),
                  ],
                ),
              ),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        GeneralCubit.get(context).getPostImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Image),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Upload Photo'),
                        ],
                      )),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Text('# Tags'),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
