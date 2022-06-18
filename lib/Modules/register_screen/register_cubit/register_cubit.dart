import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/register_model.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String email,
    @required String name,
    @required String phone,
    @required String password,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
        name:name ,
        email:email,
        phone: phone,
        uId: value.user.uid,
       );
     }).catchError((error) {
      emit(RegisterErrorState());
    });
  }

  RegisterModel registerModel;
    createUser({
    @required String name,
    @required String phone,
    @required String email,
    String bio = 'write your bio ...',
    @required String uId,
    bool isVerified = false,
  }) {

    registerModel = RegisterModel(
        name: name,
        phone: phone,
        email: email,
        uId: uId,
        image: 'https://img.freepik.com/free-photo/smiling-woman-shirt-pointing-looking-up_171337-1618.jpg?w=740',
        cover: 'https://img.freepik.com/free-photo/smiling-woman-shirt-pointing-looking-up_171337-1618.jpg?w=740',
        bio: bio,
        isVerified: isVerified);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(registerModel.toMap())
        .then((value) {

      emit(CreateUserSuccessState(registerModel.uId));
    })
        .catchError((error) {
        print('error is : ${error.toString}' );
      emit(CreateUserErrorState());

    });
  }

//   registerUser(
//   {
//   @required String email,
//   @required String password,
//   @required context,
//   @required widget,
//
// }
//     ){
//   emit(RegisterLoadingState());
//   FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email, password: password)
//       .then((value) {
// navigateAndFinish(context: context, widget: widget);
//     emit(RegisterSuccessState());
//
//   })
//       .catchError((error){
//
//     emit(RegisterErrorState());
//
//   });
// }
}
