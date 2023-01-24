import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layout/cubit/cubit.dart';
import 'package:social_project/layout/cubit/states.dart';
import 'package:social_project/shared/components/components.dart';
import 'package:social_project/shared/styles/colors.dart';
// ignore: must_be_immutable
class NewPostScreen extends StatelessWidget {
    NewPostScreen({Key? key}) : super(key: key);
   var textController = TextEditingController();
   @override
  Widget build(BuildContext context)
  {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: defaultAppBar(
                context: context,
                title: 'Create Post',
                actions:
                [
                  TextButton(
                      onPressed: ()
                      {
                        var now = DateTime.now();
                        if(SocialCubit.get(context).postImage == null )
                        {
                          SocialCubit.get(context).createPost(
                              date: now.toString(),
                              text: textController.text
                          );
                        }else
                        {
                          SocialCubit.get(context).upLoadPostImage(
                              date: now.toString(),
                              text: textController.text,
                          );
                        }
                      },
                      child: const Text(
                          'Post',
                        style: TextStyle(
                          fontSize: 25
                        ),
                      )
                  ),
                ]
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                if(state is SocialUploadPostLoadingState || state is SocialCreatePostLoadingState)
                const LinearProgressIndicator(),
                if(state is SocialUploadPostLoadingState || state is SocialCreatePostLoadingState)
                const SizedBox(height:10,),
                Row(
                  children:
                   [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).userModel?.image}'
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        '${SocialCubit.get(context).userModel?.name}',
                        style: const TextStyle(height: 1.5),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration:  InputDecoration(
                        hintText: 'What is In Your Mind ${SocialCubit.get(context).userModel?.name} ?',
                      border: InputBorder.none
                    ),
                  ),
                ),
                const SizedBox(height:30.0,),
                if(SocialCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 170.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(
                            5.0,
                        ),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 16.0,
                        child: Icon(
                          Icons.close,
                          size: 23,
                          color: defaultColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height:30.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        const [
                          Icon(
                            Icons.image,
                            size: 27,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'AddPhoto',
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        ],
                      )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: (){},
                          child: const Text(
                            '#tags',
                            style: TextStyle(
                                fontSize: 18
                            ),
                          )
                      ),
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
