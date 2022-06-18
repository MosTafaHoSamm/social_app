import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/colors.dart';

AppBar defaultAppBar({
  List<Widget> actions,
  String text,
  context,
  IconData icon,
}) {
  return AppBar(
    titleSpacing: 0,
    title: Text(text),
    leading: IconButton(
      icon: Icon(icon),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: actions,
  );
}

void navigateAndReturn({@required context, @required widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(  {@required context, @required widget}) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget defaultTextForm({
  @required TextEditingController controller,
  @required String text,
  @required String prefixText,
  @required IconData iconPrefix,
  IconData suffixIcon,
  bool obsecure = false,
  @required Function(String value) validate,
  @required Function(String value) onSubmit,
  @required Function(String value) onChange,
  @required TextInputType type,
}) {
  return TextFormField(

    controller: controller,
    decoration: InputDecoration(

      label: Text(text),
      prefixIcon: Icon(iconPrefix),
      border: OutlineInputBorder(),
      suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      prefixText: prefixText,
    ),
    obscureText: obsecure,
    validator: validate,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    keyboardType: type,
  );
}

Widget defaultButton({
  @required double radius = 8,
  @required double height = 40,
  @required Function() onPressed,
  @required String text,
}) {
  return Container(
      decoration: BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      height: height,
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ));
}

Widget defaultTextButton({
  @required String text,
  @required Function() onPressed,

}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(text.toUpperCase(),style: TextStyle(color:Colors.deepOrange),),
  );
}
Widget divider(){
  return Container(
   height: 1,
   color: Colors.grey[300],
    );
}
void showToast({
  @required String text,
  @required    state,
}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseColor(  state),
      textColor: Colors.red,

      fontSize: 16.0  );
}
enum toastState{ERROR,SUCCESS,WARNING}
Color color;
Color chooseColor(  toastState state){
  switch(state) {
    case toastState.ERROR:
      color = Colors.red;
      break;
    case toastState.WARNING:
      color = Colors.amber;
      break;
    case toastState.SUCCESS:
      color = Colors.green;
      break;
  }
        return color;

}

