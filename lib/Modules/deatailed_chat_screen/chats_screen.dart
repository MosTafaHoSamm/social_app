import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social3/Models/message_model.dart';
import 'package:social3/Models/register_model.dart';
import 'package:social3/layout/social_layout.dart';
import 'package:social3/shared/components/components.dart';
import 'package:social3/shared/cubit/general_cubit.dart';
import 'package:social3/shared/cubit/general_states.dart';
import 'package:social3/shared/styles/colors.dart';
import 'package:social3/shared/styles/icon_broken.dart';

import '../chats_screen/chats_screen.dart';

class DetailsChatScreen extends StatelessWidget {
  final RegisterModel registerModel;
  var textController = TextEditingController();
  DetailsChatScreen(this.registerModel);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        GeneralCubit.get(context).getMessage(receiverId: registerModel.uId);
        return BlocConsumer<GeneralCubit, GeneralStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    navigateAndFinish(context: context, widget: SocialLayout());
                  },
                  icon: Icon(IconBroken.Arrow___Left_2),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            NetworkImage('${registerModel.image}')),
                    SizedBox(width: 10),
                    Text(
                      '${registerModel.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 12),
                    )
                  ],
                ),
                titleSpacing: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              if (GeneralCubit.get(context)
                                      .messages[index]
                                      .receiverId ==
                                  registerModel.uId)
                                myMessage(
                                    GeneralCubit.get(context).messages[index],
                                    index),
                              if (GeneralCubit.get(context)
                                      .messages[index]
                                      .receiverId !=
                                  registerModel.uId)
                                message(
                                    GeneralCubit.get(context).messages[index],
                                    index)
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: GeneralCubit.get(context).messages.length,
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: textController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 12),
                              decoration: InputDecoration(
                                  hintText: 'type your message ...',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: defaultColor,
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    GeneralCubit.get(context).sendMessage(
                                        receiverId: registerModel.uId,
                                        text: textController.text,
                                        dateTime: DateTime.now().toString());
                                  },
                                  icon: Icon(
                                    IconBroken.Send,
                                    color: Colors.white,
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget message(MessageModel model, index) {
  return Align(
    alignment: AlignmentDirectional.topStart,
    child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Colors.grey[300]),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(
            '${model.text}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        )),
  );
}

Widget myMessage(MessageModel model, index) {
  return Align(
    alignment: AlignmentDirectional.topEnd,
    child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            color: defaultColor.withOpacity(1)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12.0),
          child: Text(
            '${model.text}',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        )),
  );
}
