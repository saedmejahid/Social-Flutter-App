import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layout/socialayout.dart';
import 'package:social_project/modules/loginscreen/cubit/cubit.dart';
import 'package:social_project/modules/loginscreen/cubit/states.dart';
import 'package:social_project/modules/register_screen/Social_register_screen.dart';
import 'package:social_project/shared/components/components.dart';
import 'package:social_project/shared/network/local/cache_helper.dart';
import 'package:social_project/shared/styles/colors.dart';
// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var loginEmailShopController = TextEditingController();
  var loginPasswordShopController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state)
        {
          if(state is SocialLoginErrorState)
          {
            showToast(
                text: state.error,
                state: ToastStates.errorr
            );
          }
          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(
                key: 'uId',
                value:state.uId,
            ).then((value)
            {
              navigateAndFinsh(context,const SocialLayout());
            }).catchError((error)
            {
              debugPrint(error.toString());
            });
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        const Image(
                          image: AssetImage(
                            'assets/images/loginimage.jpeg',
                          ),
                          width: 200.0,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color:defaultColor,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'LOGIN Now To Communicate with Friends',
                          style: Theme.of(context).textTheme.bodyText1 ?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: defaultForm(
                            onTap: () {},
                            onChange: () {},
                            controller: loginEmailShopController,
                            type: TextInputType.emailAddress,
                            lapel: 'Email Address',
                            prefix: Icons.email_outlined,
                            validate: (String value)
                            {
                              if (value.isEmpty)
                              {
                                return 'Please Enter Your Email ';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          child: defaultForm(
                              onTap: () {},
                              onChange: () {},
                              controller: loginPasswordShopController,
                              type: TextInputType.visiblePassword,
                              lapel: 'Password',
                              prefix: Icons.lock_outline,
                              suffix: SocialLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                SocialLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              isPassword:
                              SocialLoginCubit.get(context).isPasswordShown,
                              validate: (String value)
                              {
                                if (value.isEmpty)
                                {
                                  return 'Please Enter Your Password';
                                }
                                return null;
                              },
                              onSup: (value)
                              {
                                if (formKey.currentState!.validate())
                                {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: loginEmailShopController.text,
                                    password: loginPasswordShopController.text,
                                  );
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          builder: (BuildContext context) {
                            return defaulButton(
                              text: 'Login',
                              isUpperCase: true,
                              pressed: () {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: loginEmailShopController.text,
                                    password: loginPasswordShopController.text,
                                  );
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                                'Don\'t Have an account?'
                            ),
                            TextButton(
                              onPressed: ()
                              {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              child: Text(
                                'register now'.toUpperCase(),
                                style:  const TextStyle(
                                    color: defaultColor
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

