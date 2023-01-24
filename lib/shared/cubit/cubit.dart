// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_project/shared/cubit/states.dart';
// class AppCubit extends Cubit<AppStates>
// {
//   AppCubit():super(AppInitialState());
//   static AppCubit get (context) => BlocProvider.of(context);
//
//   void changeIndex(int index)
//   {
//     currentIndex = index;
//     emit(AppChangeBottomNavBarState());
//   }
//   int currentIndex = 0;
//   bool isBottomSheetShown = false;
//   IconData fabIcon = Icons.edit;
//   void changeBottomSheetSate({
//     required bool isShow,
//     required IconData icon,
//   }){
//     isBottomSheetShown = isShow;
//     fabIcon = icon;
//     emit(AppChangeBottomSheetSate());
//   }
//
// }
//
//
