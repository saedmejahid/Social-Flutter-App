import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layout/cubit/cubit.dart';
import 'package:social_project/layout/cubit/states.dart';
import 'package:social_project/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_project/modules/new_post_screen/new_post_screen.dart';
import 'package:social_project/shared/components/components.dart';
import 'package:social_project/shared/styles/colors.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 210.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children:
                    [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 170.0,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0)),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${userModel?.cover}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 63,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child:  CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            '${userModel?.image}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${userModel?.name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${userModel?.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: ()
                          {

                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '22',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: ()
                          {

                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '10K',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Flowers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: ()
                          {

                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '60',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: ()
                          {

                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children:
                  [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: ()
                        {
                          navigateTo(context, NewPostScreen());
                        },
                        child:const Text(
                          'Add Posts',
                          style: TextStyle(
                            color: defaultColor
                          ),
                        ) ,
                      )
                    ),
                    const SizedBox(
                      width:10.0,
                    ),
                    OutlinedButton(
                      onPressed: ()
                      {
                        navigateTo(context, EditProfile());
                      },
                      child:const Icon(
                        Icons.edit,
                        color: defaultColor,
                      ) ,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
