import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social3/Models/message_model.dart';
import 'package:social3/Modules/register_screen/register_cubit/register_state.dart';

import '../../Models/like_model.dart';
import '../../Models/post_model.dart';
import '../../Models/register_model.dart';
import '../../Modules/chats_screen/chats_screen.dart';
import '../../Modules/feeds_screen/feeds_screen.dart';
import '../../Modules/post_screen/post_screen.dart';
import '../../Modules/settings_screen/settings_screen.dart';
import '../../Modules/users_screen/users_screen.dart';
import '../components/constant.dart';
import '../network/local/cache_helper.dart';
import '../styles/icon_broken.dart';
import 'general_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class GeneralCubit extends Cubit<GeneralStates> {
  GeneralCubit() : super(GeneralInitialStates());
  static GeneralCubit get(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Feeds'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chats'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Location), label: 'Users'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Setting), label: 'Settings'),
  ];
  int currentIndex = 0;
  void changeNavigation(
    index,
    context,
  ) {
    if (index == 0) {
      CacheHelper.saveData(key: 'uid', value: uid);
    }
    if (index == 2) {
      emit(SocialPostScreenState());
    } else {
      currentIndex = index;

      emit(ChangeNavigationState());
    }
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PostsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> title = [
    'Feeds',
    'Chat',
    'Post',
    'Users',
    'Setting',
  ];
  RegisterModel registerModel;

  void getUserData() {
    emit(GetUserDataLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      registerModel = RegisterModel.fromJson(value.data());
      print(registerModel.image);
      print(registerModel.name);
      print(registerModel.bio);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  File image;
  var profilePicker = ImagePicker();

  Future<void> getProfile() async {
    var pickedFile = await profilePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(PickedProfileSuccessState());
    } else {
      emit(PickedProfileErrorState());

      print('There is No Photo Selected ');
    }
  }

  File cover;
  Future<void> getCover() async {
    var pickedFile = await profilePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      cover = File(pickedFile.path);
      emit(PickedCoverSuccessState());
    } else {
      emit(PickedCoverErrorState());

      print('There is No Photo Selected ');
    }
  }

  void uploadProfile({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(UploadProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('photos/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userUpdate(name: name, bio: bio, phone: phone, image: value);

        emit(UploadProfileSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadProfileErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileErrorState());
    });
  }

  void uploadCover({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(UploadCoverLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('coverPhotos/${Uri.file(cover.path).pathSegments.last}')
        .putFile(cover)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userUpdate(name: name, bio: bio, phone: phone, cover: value);
        emit(UploadCoverSuccessState());
      }).catchError((error) {
        emit(UploadCoverErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverErrorState());
    });
  }

  void userUpdate({
    @required String name,
    @required String bio,
    @required String phone,
    String image,
    String cover,
  }) {
    emit(UpdateUserLoadingState());
    registerModel = RegisterModel(
        uId: registerModel.uId,
        name: name,
        bio: bio,
        phone: phone,
        cover: cover ?? registerModel.cover,
        image: image ?? registerModel.image,
        isVerified: registerModel.isVerified,
        email: registerModel.email);
    FirebaseFirestore.instance
        .collection('users')
        .doc(registerModel.uId)
        .update(registerModel.toMap())
        .then((value) {
      emit(UpdateUserSuccessState());
    }).catchError((error) {
      emit(UpdateUserErrorState());
      print(error.toString());
    });
  }

  File postImage;
  Future<void> getPostImage() async {
    var pickedFile = await profilePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PickedPostImageSuccessState());
    } else {
      print('There ');
      emit(PickedPostImageErrorState());
    }
  }

  void uploadPostImage({
    @required String content,
    @required String dateTime,
  }) {
    emit(UploadPostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('postsPhotos/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(content: content, postImage: value, dateTime: dateTime);

        emit(UploadPostSuccessState());
      }).catchError((error) {
        emit(UploadPostLoadingState());
      });
    }).catchError((error) {
      emit(UploadPostErrorState());
    });
  }

  PostModel postModel;
  void createPost({
    @required String content,
    String postImage,
    @required String dateTime,
  }) {
    emit(CreatePostLoadingState());

    postModel = PostModel(
        name: registerModel.name,
        image: registerModel.image,
        uId: registerModel.uId,
        date: dateTime,
        content: content,
        postImage: postImage ?? '');
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void removePost() {
    postImage = null;
    emit(RemovePostImageState());
  }

  List<PostModel> posts = [];
  List<int> likes = [];
  List<String> postIds = [];
  void getPosts() {

    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for(var element in value.docs){
        element.reference.collection('likes').get().then((value) {

          posts.add(PostModel.fromJson(element.data()));

          postIds.add(element.id);
          likes.add(value.docs.length);

          print('Likes ${likes.length}');


        });

        emit(GetPostsSuccessState());

            }}).catchError((error) {
      print(error.toString());
      emit(GetPostsErrorState());
    });
  }

  List<RegisterModel> users = [];
  getUsers() {
    users = [];
    emit(GetUsersLoadingState());

    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (registerModel.uId != element.id)
          users.add(RegisterModel.fromJson(element.data()));
      });

      emit(GetUsersSuccessState());
    }).catchError((error) {
      emit(GetUsersErrorState());
    });
  }

  MessageModel messageModel;

  void sendMessage({
    @required String receiverId,
    @required String text,
    @required String dateTime,
  }) {
    emit(SendMessageLoadingState());
    messageModel =
        MessageModel(receiverId: receiverId, dateTime: dateTime, text: text);

    FirebaseFirestore.instance
        .collection('users')
        .doc(registerModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(registerModel.uId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessage({
    @required String receiverId,
  }) {
    messages = [];
    emit(GetMessageLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(registerModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        emit(GetMessageSuccessState());
      });
    });
    emit(GetMessageSuccessState());
  }

  void likePost(
  {
  @required String postId,
}
      ) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(registerModel.uId)
        .set({'like': true})
        .then((value) {
emit(LikePostSuccessState());

    })
        .catchError((error) {

      emit(LikePostErrorState());



    });
  }
}
