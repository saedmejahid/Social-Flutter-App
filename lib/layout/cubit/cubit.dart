import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_project/layout/cubit/states.dart';
import 'package:social_project/models/messagemodel.dart';
import 'package:social_project/models/post_model.dart';
import 'package:social_project/models/usermodel.dart';
import 'package:social_project/modules/chats_screen/chat_screen.dart';
import 'package:social_project/modules/feeds_screen/feeds_screen.dart';
import 'package:social_project/modules/new_post_screen/new_post_screen.dart';
import 'package:social_project/modules/settings_screen/settings_screen.dart';
import 'package:social_project/modules/users_screen/users_screen.dart';
import 'package:social_project/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;
  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value)
    {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error)
    {
      debugPrint(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex =0;
  List<String> titles =
  [
    'News Feed',
    'Chats',
    'New Post',
    'Users',
    'Profile',
  ];
  List<Widget> screens =
  [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

void changeBottomNav (int index)
 {
   if(index == 1)
   {
     getAllUsers();
   }
  if(index == 2)
  {
    emit(SocialNewPostState());
  }else
  {
    currentIndex = index;
    emit(SocialChangeNavBarState());
  }
}
  final picker = ImagePicker();
  File? profileImage;
  Future getProfileImage() async
  {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
    );
    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      debugPrint(pickedFile.path);
      emit(SocialProfilePickSuccessState());
    }else
    {
      debugPrint('No Image Selected');
      emit(SocialProfilePickErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
}) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage
        .FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        debugPrint(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            image: value
        );
      }).catchError((error)
      {
        emit(SocialUploadProfileErrorState());
        debugPrint(error.toString());
      });
    }).catchError((error)
    {
      debugPrint(error.toString());
      emit(SocialUploadProfileErrorState());

    });
  }

  File? coverImage;
  Future getCoverImage() async
  {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery
    );
    if(pickedFile != null)
    {
      coverImage = File(pickedFile.path);
      emit(SocialProfileCoverPickSuccessState());
    }else
    {
      debugPrint('No Image Selected');
      emit(SocialProfileCoverPickErrorState());
    }
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
})
  {
    emit(SocialUserUpdateCoverLoadingState());

    firebase_storage
        .FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        debugPrint(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            cover: value,
        );
      }).catchError((error)
      {
        emit(SocialUploadCoverErrorState());
        debugPrint(error.toString());
      });
    }).catchError((error)
    {
      emit(SocialUploadCoverErrorState());

    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  })
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel?.email,
      image: image ?? userModel?.image,
      cover:cover ?? userModel?.cover,
      uId: userModel?.uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance.collection('users').doc(userModel?.uId).update(model.toMap())
        .then((value)
    {
      getUserData();
    }).catchError((error)
    {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;
  Future getPostImage() async
  {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
    );
    if(pickedFile != null)
    {
      postImage = File(pickedFile.path);
      emit(SocialPostSuccessState());
    }else
    {
      debugPrint('No Image Selected');
      emit(SocialPostErrorState());
    }
  }

  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void upLoadPostImage({
    required String date,
    required String text,
  })
  {
    emit(SocialUploadPostLoadingState());

    firebase_storage
        .FirebaseStorage
        .instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!).then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        debugPrint(value);
       createPost(
           date: date,
           text: text,
         postImage: value,
       );
      }).catchError((error)
      {
        emit(SocialUploadPostErrorState());
        debugPrint(error.toString());
      });
    }).catchError((error)
    {
      emit(SocialUploadPostErrorState());

    });
  }

  void createPost({
    required String date,
    required String text,
     String? postImage,
  })
  {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel?.uId,
      date: date,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialCreatePostSuccessState());
    }).catchError((error)
    {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes =[];
  void getPosts()
  {
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value)
    {
      for (var element in value.docs) {
        element.reference.collection('likes')
            .get()
            .then((value)
        {
          postsId.add(element.id);
          likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error){});
      }
      emit(SocialGetPostSuccessState());
    }).catchError((error)
    {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uId)
        .set({
      'like':true,
    }).then((value)
    {
      emit(SocialLikePostSuccessState());
    }).catchError((error)
    {
      debugPrint(error.toString());
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users =[];
  void getAllUsers()
  {
    if(users.isEmpty)
    {
      emit(SocialGetAllUserLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value)
      {
        for (var element in value.docs)
        {
          if(element.data()['uId'] != userModel?.uId)
          {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        }
        emit(SocialGetAllUserSuccessState());
      }).catchError((error)
      {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
  })
  {
    MessageModel model = MessageModel(
      text: text,
      receiverId: receiverId,
      senderId: userModel?.uId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('users')
    .doc(userModel?.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
    .then((value)
    {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error)
    {
      emit(SocialSendMessagesErrorState(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialGetMessagesSuccessState());
    }).catchError((error)
    {
      emit(SocialGetMessagesErrorState(error.toString()));
    });

  }

  List<MessageModel> messages = [];

  void getMessage({
    required String receiverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessagesSuccessState());
    });
  }



}













