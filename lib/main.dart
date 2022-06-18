  import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
 import 'package:social3/shared/bloc_opserver.dart';
import 'package:social3/shared/components/components.dart';
import 'package:social3/shared/components/constant.dart';
import 'package:social3/shared/cubit/general_cubit.dart';
import 'package:social3/shared/network/local/cache_helper.dart';
import 'package:social3/shared/styles/themes.dart';

import 'Modules/login_screen/login_screen.dart';
import 'Modules/register_screen/register_cubit/register_cubit.dart';
import 'Modules/register_screen/register_screen.dart';
import 'layout/social_layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


  Future<void>onBackgroundHandler(RemoteMessage message)async{
       Fluttertoast.showToast(
        msg: 'onMessage ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green.withOpacity( .5),
        textColor: Colors.white,

        fontSize: 16.0  );
    print('Onbackground');
  }
void main()async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(  );

  Widget widget;


var token= await FirebaseMessaging.instance.getToken();
print('${token}=  token');
FirebaseMessaging.onMessage.listen((event) {
  print(event.data.toString());
  Fluttertoast.showToast(
      msg: 'onMessage ',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green.withOpacity( .5),
      textColor: Colors.white,

      fontSize: 16.0  );
});
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    Fluttertoast.showToast(
        msg: 'onMessage ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green.withOpacity( .5),
        textColor: Colors.white,

        fontSize: 16.0  );
  });
  FirebaseMessaging.onBackgroundMessage( onBackgroundHandler );



  await CacheHelper.init();
  uid=CacheHelper.getSavedData(key: 'uId');

  if(uid!=null) {
    widget=SocialLayout();
  } else {
    widget=LoginScreen();
  }
  print(uid);
  BlocOverrides.runZoned(
    () {

      runApp(MyApp(starWidget: widget,));
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
    Widget starWidget;

    MyApp({this.starWidget}) ;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (  context) => GeneralCubit()..getUserData()..getPosts()),
        BlocProvider(create: (  context) => RegisterCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home:starWidget,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
