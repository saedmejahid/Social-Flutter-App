import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layout/cubit/cubit.dart';
import 'package:social_project/layout/cubit/states.dart';
import 'package:social_project/shared/components/components.dart';
import 'package:social_project/shared/styles/colors.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: defaultColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 210.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 170.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0)),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                            '${userModel.cover}',
                                          )
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 16.0,
                                  child: Icon(
                                    Icons.photo_camera_rounded,
                                    size: 23,
                                    color: defaultColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 63,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${userModel.image}')
                                      : FileImage(profileImage)
                                          as ImageProvider),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 16.0,
                                child: Icon(
                                  Icons.photo_camera_rounded,
                                  size: 23,
                                  color: defaultColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(children: [
                              defaulButton(
                                heghit: 40,
                                width: 175,
                                text: 'Upload Profile',
                                pressed: () {
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                            ]),
                          ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(children: [
                              defaulButton(
                                heghit: 40,
                                width: 175,
                                text: 'Upload Cover',
                                pressed: () {
                                  SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (state is SocialUserUpdateCoverLoadingState)
                                const LinearProgressIndicator(),
                            ]),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(
                      height: 10.0,
                    ),
                  SizedBox(
                    height: 40.0,
                    child: defaultForm(
                      controller: nameController,
                      type: TextInputType.text,
                      lapel: 'Edit Name',
                      prefix: Icons.person_pin,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Name Must Not Be Empty';
                        }
                        return null;
                      },
                      onTap: () {},
                      onChange: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 40.0,
                    child: defaultForm(
                      controller: phoneController,
                      type: TextInputType.phone,
                      lapel: 'Edit Phone',
                      prefix: Icons.phone_android_outlined,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Phone Must Not Be Empty';
                        }
                        return null;
                      },
                      onTap: () {},
                      onChange: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 40.0,
                    child: defaultForm(
                      controller: bioController,
                      type: TextInputType.text,
                      lapel: 'Edit Bio...',
                      prefix: Icons.title,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Bio Must Not Be Empty';
                        }
                        return null;
                      },
                      onTap: () {},
                      onChange: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
