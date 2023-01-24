import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/bloc_observer.dart';
import 'package:social_project/layout/cubit/cubit.dart';
import 'package:social_project/layout/socialayout.dart';
import 'package:social_project/modules/loginscreen/loginscreen.dart';
import 'package:social_project/shared/components/constants.dart';
import 'package:social_project/shared/network/local/cache_helper.dart';
import 'package:social_project/shared/styles/themes.dart';
void main()async
{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;
   uId = CacheHelper.getData(key: 'uId');
  if(uId != null)
  {
    widget = const SocialLayout();
  }else
  {
    widget = LoginScreen();
  }
  runApp( MyApp(
    startWidget:widget,
  ));
}
// ignore: must_be_immutable
class MyApp extends StatelessWidget
{
   MyApp({super.key,this.startWidget});
  Widget? startWidget;
  @override
  Widget build(BuildContext context)
  {
    return  BlocProvider(
      create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
