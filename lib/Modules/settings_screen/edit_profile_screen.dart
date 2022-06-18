import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social3/shared/cubit/general_cubit.dart';
import 'package:social3/shared/cubit/general_states.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = GeneralCubit.get(context).registerModel.name;
        bioController.text = GeneralCubit.get(context).registerModel.bio;
        phoneController.text = GeneralCubit.get(context).registerModel.phone;
        return Scaffold(
          appBar: AppBar(
            actions: [
              defaultTextButton(
                  text: 'Update',
                  onPressed: () {
                    GeneralCubit.get(context).userUpdate(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text);
                  })
            ],
            titleSpacing: 0,
            title: Text(
              'Edit Profile',
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is UpdateUserLoadingState)
                      LinearProgressIndicator(),
                    Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                alignment: AlignmentDirectional.topCenter,
                                height: 260,
                                child: Card(
                                    elevation: 10,
                                    child: Container(
                                      height: 180,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              topRight: Radius.circular(4)),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: GeneralCubit.get(context)
                                                          .cover ==
                                                      null
                                                  ? NetworkImage(
                                                      '${GeneralCubit.get(context).registerModel.cover}')
                                                  : FileImage(
                                                      GeneralCubit.get(context)
                                                          .cover))),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    top: 15, end: 15),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 23,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.grey.withOpacity(.5),
                                    child: IconButton(
                                      onPressed: () {
                                        GeneralCubit.get(context).getCover();
                                      },
                                      icon: Icon(
                                        IconBroken.Camera,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                maxRadius: 64,
                                child: CircleAvatar(
                                  maxRadius: 60,
                                  backgroundImage: GeneralCubit.get(context)
                                              .image ==
                                          null
                                      ? NetworkImage(
                                          '${GeneralCubit.get(context).registerModel.image}')
                                      : FileImage(
                                          GeneralCubit.get(context).image),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 23,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.withOpacity(.5),
                                  child: IconButton(
                                    onPressed: () {
                                      GeneralCubit.get(context).getProfile();
                                    },
                                    icon: Icon(
                                      IconBroken.Camera,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    if (GeneralCubit.get(context).image != null ||
                        GeneralCubit.get(context).cover != null)
                      Row(
                        children: [
                          if (GeneralCubit.get(context).cover != null)
                            Expanded(
                              child: Column(
                                children: [
                                  if (state is UploadProfileLoadingState)
                                    LinearProgressIndicator(),
                                  Container(
                                      width: double.infinity,
                                      child: MaterialButton(
                                        color: Colors.deepOrange,
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          GeneralCubit.get(context).uploadCover(
                                              phone: phoneController.text,
                                              bio: bioController.text,
                                              name: nameController.text);
                                          GeneralCubit.get(context).image == null;
                                        },
                                        child: Text('Update Cover',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17)),
                                      ))
                                ],
                              ),
                            ),
                          SizedBox(
                            width: 10,
                          ),
                          if (GeneralCubit.get(context).image != null)
                            Expanded(
                              child: Column(
                                children: [
                                  if (state is UploadProfileLoadingState)
                                    LinearProgressIndicator(),
                                  Container(
                                      width: double.infinity,
                                      child: MaterialButton(
                                        color: Colors.deepOrange,
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          GeneralCubit.get(context)
                                              .uploadProfile(
                                            name: nameController.text,
                                            bio: bioController.text,
                                            phone: phoneController.text,
                                          );
                                        },
                                        child: Text(
                                          'Update Profile',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                        ],
                      ),

                    Container(
                      height: 50,
                      child: defaultTextForm(
                        controller: nameController,
                        text: 'name',
                        iconPrefix: IconBroken.User,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'please Enter value';
                          }
                        },
                        onSubmit: (value) {},
                        onChange: (value) {},
                        type: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      child: defaultTextForm(
                          controller: bioController,
                          text: 'Bio',
                          iconPrefix: IconBroken.Info_Circle,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please Enter value';
                            }
                          },
                          onSubmit: (value) {},
                          onChange: (value) {},
                          type: TextInputType.name),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      child: defaultTextForm(
                          controller: phoneController,
                          text: 'phone',
                          iconPrefix: IconBroken.Call,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please Enter value';
                            }
                          },
                          onSubmit: (value) {},
                          onChange: (value) {},
                          type: TextInputType.phone),
                    ),

                    // MaterialButton(
                    //   onPressed:
                    //   child: Text('Logout'.toUpperCase()),
                    // )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
