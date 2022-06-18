import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Modules/post_screen/post_screen.dart';
import '../shared/cubit/general_cubit.dart';
import '../shared/cubit/general_states.dart';
import '../shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralStates>(
      listener: (context, state) {
        if(state is SocialPostScreenState)
          // navigateAndFinish(context: context, widget: PostsScreen());
          Navigator.push(context,MaterialPageRoute(builder: (context)=>PostsScreen()));
      },
      builder: (context, state) {
        var cubit = GeneralCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${cubit.title[cubit.currentIndex]}',
              style: TextStyle(fontFamily: 'mostafafont',fontWeight: FontWeight.normal),
            ),
            actions: [
              IconButton(
                icon: Icon(IconBroken.Search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(IconBroken.Notification),
                onPressed: () {},
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.items,
            onTap: (index) {
              cubit.changeNavigation(index,context,);
            },
          ),
          body:  cubit.screens[cubit.currentIndex]
        );
      },
    );
  }
}
