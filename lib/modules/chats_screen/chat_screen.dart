import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layout/cubit/cubit.dart';
import 'package:social_project/layout/cubit/states.dart';
import 'package:social_project/models/usermodel.dart';
import 'package:social_project/modules/chat_details/chat_details_screen.dart';
import 'package:social_project/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (BuildContext context)=> ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)
              {
                return buildChatItem(context,SocialCubit.get(context).users[index]);
              },
              separatorBuilder: (context,index) =>myDivider(),
              itemCount: SocialCubit.get(context).users.length
          ),
          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(context,SocialUserModel model) =>  InkWell(
    onTap: ()
    {
      navigateTo(context, ChatDetails(
        userModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
           CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            '${model.name}',
            style: const TextStyle(height: 1.5),
          ),
        ],
      ),
    ),
  );
}
