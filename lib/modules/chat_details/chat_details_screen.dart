import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layout/cubit/cubit.dart';
import 'package:social_project/layout/cubit/states.dart';
import 'package:social_project/models/messagemodel.dart';
import 'package:social_project/models/usermodel.dart';
import 'package:social_project/shared/styles/colors.dart';

// ignore: must_be_immutable
class ChatDetails extends StatelessWidget {
  SocialUserModel? userModel;
  ChatDetails({super.key, this.userModel});
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return  Builder(
      builder: (BuildContext context)
      {
        SocialCubit.get(context).getMessage(receiverId: userModel!.uId!);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context,state)
          {
            return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children:
                    [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          '${userModel?.image}',
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(
                          '${userModel?.name}'
                      ),
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: SocialCubit.get(context).messages.isNotEmpty || SocialCubit.get(context).messages.isEmpty,
                  builder: (BuildContext context)
                  {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context,index)
                                {
                                  var message = SocialCubit.get(context).messages[index];
                                  if(SocialCubit.get(context).userModel?.uId == message.senderId)
                                  {
                                    return buildMyMessage(message);
                                  } else
                                  {
                                    return buildMessage(message);
                                  }
                                },
                                separatorBuilder: (context,index) => const SizedBox(height: 15,),
                                itemCount: SocialCubit.get(context).messages.length
                      ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children:
                              [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: TextFormField(
                                      controller:messageController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Type Your Message Here...',

                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  color: defaultColor,
                                  child: MaterialButton(
                                      minWidth: 1,
                                      child: const Icon(
                                        Icons.send,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      onPressed: ()
                                      {
                                        SocialCubit.get(context).sendMessage(
                                          receiverId: userModel!.uId!,
                                          text: messageController.text,
                                          dateTime: DateTime.now().toString(),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                    fallback: (BuildContext context) => const Center(child: CircularProgressIndicator())

                ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) =>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration:  BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          )
      ),
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child:  Text(
        model.text,
      ),
    ),
  );
  Widget buildMyMessage(MessageModel model) =>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration:  const BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      child:  Text(
        model.text.toString(),
        style: const TextStyle(
            color: Colors.white,
        ),
      ),
    ),
  );

}
