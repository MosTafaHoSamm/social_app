import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social3/Models/register_model.dart';
import 'package:social3/Modules/deatailed_chat_screen/chats_screen.dart';
import 'package:social3/shared/components/components.dart';
import 'package:social3/shared/cubit/general_cubit.dart';
import 'package:social3/shared/cubit/general_states.dart';

class ChatsScreen extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return Builder(
      builder:(context){
        GeneralCubit.get(context).getUsers();
        return BlocConsumer<GeneralCubit,GeneralStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: GeneralCubit.get(context).users.length,
              itemBuilder: (context, index) {
                return chatItem(context,GeneralCubit.get(context).users[index],index);
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                );
              },
            );
          },
        );
      }
    );
  }

}
Widget chatItem(context,RegisterModel model,index){
  return InkWell(
    onTap: () {
      navigateAndReturn(context: context, widget: DetailsChatScreen(model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('${model.image}')),
          SizedBox(width: 10),
          Text(
            '${model.name}',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 14),
          )
        ],
      ),
    ),
  );
}
