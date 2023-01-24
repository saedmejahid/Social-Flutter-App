import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/models/usermodel.dart';
import 'package:social_project/modules/register_screen/cubit/register_states.dart';
class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    debugPrint('hello');
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      debugPrint(value.user!.email);
      debugPrint(value.user!.uid);
      userCreate(
          email: email,
          name: name,
        phone: phone,
        uId: value.user!.uid,
      );

    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      bio: 'Write Your Bio...',
      isEmailVerified: false,
      image: 'https://img.freepik.com/premium-photo/photo-positive-african-american-girl-with-curly-hair-keeps-hand-chin-smiles-gladfully-listens-attentively-good-news-wears-round-spectacles-casual-beige-t-shirt-isolated-white-background_273609-54636.jpg',
      cover: 'https://img.freepik.com/free-photo/close-up-portrait-attractive-young-woman-isolated_273609-36129.jpg?t=st=1673652617~exp=1673653217~hmac=7fba7d9eb483613a9617a62d16dcbcbbb3779caebda5639eb7c782422968ce2d',
    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).then((value)
    {
      emit(SocialCreateUserSuccessState());
    }).catchError((error)
    {
      debugPrint(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(SocialChangePasswordVisibilityState());
  }
}
