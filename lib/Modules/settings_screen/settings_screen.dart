import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social3/Modules/register_screen/register_cubit/register_cubit.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/general_cubit.dart';
import '../../shared/cubit/general_states.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/icon_broken.dart';
import '../login_screen/login_screen.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit,GeneralStates>(
      listener: (context,state){
      },
      builder: (context,state){
        var cubit=GeneralCubit.get(context);
          // RegisterModel model =cubit.registerModel;
        return  SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 250,
                    alignment: AlignmentDirectional.topCenter,
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage('${GeneralCubit.get(context).registerModel.cover}'))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 74,
                    child: CircleAvatar(
                      maxRadius: 70,
                     backgroundImage: NetworkImage(
                          '${GeneralCubit.get(context).registerModel.image}'),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),

              Text(
                '${GeneralCubit.get(context).registerModel.name}',
                style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15),
              ),
              SizedBox(height: 10,),

              Text(
                '${GeneralCubit.get(context).registerModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap:(){},
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15),),
                          SizedBox(height: 10,),

                          Text('Posts',style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15),),

                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap:(){},
                      child: Column(
                        children: [
                          Text('1500',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15),),
                          SizedBox(height: 10,),

                          Text('Photos',style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15),),

                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap:(){},
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15),),
                          SizedBox(height: 10,),

                          Text('Followers',style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15),),

                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap:(){},
                      child: Column(
                        children: [
                          Text('254',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15),),
                          SizedBox(height: 10,),

                          Text('Followings',style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15),),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: OutlinedButton(onPressed: (){}, child: Text('Edit Profile'))),
                    SizedBox(width: 10,),
                    OutlinedButton(onPressed: (){
                      navigateAndReturn(context: context, widget: EditProfileScreen());
                    }, child: Icon(IconBroken.Edit))
                  ],
                ),


              ),
              OutlinedButton(
                onPressed:() {
                  CacheHelper.removeData(key: 'uId');
                  navigateAndFinish(context: context, widget: LoginScreen());
                },
                child: Container(
                  width: 100,
                  child: Row(
                    children: [
                      Text('Sign Out'),
                      SizedBox(width: 20,),
                      Icon(Icons.logout_outlined),
                    ],
                  ),
                ),),


              // MaterialButton(
              //   onPressed:
              //   child: Text('Logout'.toUpperCase()),
              // )
            ],
          ),
        );
      },

    );
  }
}
