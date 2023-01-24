import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layout/cubit/cubit.dart';
import 'package:social_project/layout/cubit/states.dart';
import 'package:social_project/modules/app_notifications_screen/notifications_screen.dart';
import 'package:social_project/modules/new_post_screen/new_post_screen.dart';
import 'package:social_project/modules/search_screen/search_screen.dart';
import 'package:social_project/shared/components/components.dart';
import 'package:social_project/shared/styles/colors.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: defaultAppBar(
              context: context,
              title: cubit.titles[cubit.currentIndex],
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, const NotificationsScreen());
                  },
                  icon: const Icon(
                    Icons.notifications_on_sharp,
                    size: 28,
                    color: defaultColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    navigateTo(context,  const SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search_sharp,
                    size: 28,
                    color: defaultColor,
                  ),
                ),
              ],
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: defaultColor,
            buttonBackgroundColor: defaultColor,
            height: 70,
            animationDuration: const Duration(
              milliseconds: 1000,
            ),
            animationCurve: Curves.fastLinearToSlowEaseIn,
            items: const <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.chat,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.add_circle,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.location_on,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.account_circle,
                size: 30,
                color: Colors.white,
              ),
            ],
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
