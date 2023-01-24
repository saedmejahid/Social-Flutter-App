import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/modules/loginscreen/cubit/states.dart';
class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  static SocialLoginCubit get (context) => BlocProvider.of(context);
  SocialLoginCubit():super(SocialLoginInitialState());
  void userLogin({
  required String email,
    required String password,
})
  {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value)
    {
      debugPrint(value.user?.email);
      debugPrint(value.user?.uid);

      emit(SocialLoginSuccessState(value.user!.uid));

    }).catchError((error)
    {
      debugPrint(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility()
  {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility_off_outlined :Icons.visibility_outlined;
    emit(SocialChangePasswordVisState());
  }
}

