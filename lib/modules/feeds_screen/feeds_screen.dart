import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layout/cubit/cubit.dart';
import 'package:social_project/layout/cubit/states.dart';
import 'package:social_project/models/post_model.dart';
class FeedsScreen extends StatelessWidget
{
  const FeedsScreen({Key? key,context}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).posts.isNotEmpty || SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: const EdgeInsets.all(0.8),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      const Image(
                        image: NetworkImage(
                          'https://img.freepik.com/free-photo/joyous-friendly-looking-smiling-girl-points-aside-with-happy-expression-toothy-smile-pleased-show-awesome-advertisement_273609-33977.jpg?w=1480&t=st=1673644800~exp=1673645400~hmac=2fa43e9e1ac9e1a5c0c95e0b156a47d0697ded0122f5f23c8bb56dc7041154c3',
                        ),
                        fit: BoxFit.cover,
                        height: 250.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) => buildPostItem(context,index,SocialCubit.get(context).posts[index]),
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8,),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
              ],
            ),
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildPostItem(context,index,PostModel model) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children:
                        [
                          Text(
                            '${model.name}',
                            style: const TextStyle(height: 1.5),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 15,
                          ),
                        ],
                      ),
                      Text(
                        '${model.date}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 20,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.only(end: 3.0),
                      child: SizedBox(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#Sowftware',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.only(end: 3.0),
                      child: SizedBox(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#flutter',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.only(end: 3.0),
                      child: SizedBox(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#firebase',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(model.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 5,
              ),
              child: Container(
                height: 170.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image:  DecorationImage(
                    image: NetworkImage(
                      '${model.postImage}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:5.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.recommend_sharp,
                              color: Colors.blue,
                              size: 18.0,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style:
                              Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.chat,
                              color: Colors.green,
                              size: 18.0,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0 comment',
                              style:
                              Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 10.0
              ),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children:
              [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                         CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            '${model.image}',
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Write a comment ...',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.5),
                        ),
                      ],
                    ),
                    onTap: (){},
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.recommend_rounded,
                        color: Colors.blue,
                        size: 18.0,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap:()
                  {
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ));
}
