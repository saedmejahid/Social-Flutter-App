// ignore_for_file: file_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layout/socialayout.dart';
import 'package:social_project/modules/register_screen/cubit/cubit.dart';
import 'package:social_project/modules/register_screen/cubit/register_states.dart';
import 'package:social_project/shared/components/components.dart';
import 'package:social_project/shared/styles/colors.dart';
// ignore: must_be_immutable
class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var registerNameShopController = TextEditingController();
  var registerEmailShopController = TextEditingController();
  var registerPasswordShopController = TextEditingController();
  var registerPhoneShopController = TextEditingController();
  SocialRegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (BuildContext context, state)
        {
          if(state is SocialCreateUserSuccessState)
          {
            navigateAndFinsh(context, const SocialLayout());
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: defaultAppBar(
              context: context,
              actions:  [
                IconButton(
                  color: defaultColor,
                  onPressed: () {

                  },
                  icon: const Icon(
                      Icons.app_registration_outlined
                  ),
                ),
              ],
              title:'Register',
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        image:AssetImage(
                          'assets/images/registerlogo.jpeg',
                        ),
                        width: 200.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'register',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(
                            color:defaultColor
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Register Now To Communicate with Friends',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.black54,
                              fontSize: 20.0,
                            ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        child: defaultForm(
                          onTap: () {},
                          onChange: () {},
                          controller: registerNameShopController,
                          type: TextInputType.name,
                          lapel: 'User Name',
                          prefix: Icons.person,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Name ';
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
                            controller: registerEmailShopController,
                            type: TextInputType.emailAddress,
                            lapel: 'Email'.toUpperCase(),
                            prefix: Icons.lock_outline,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Email';
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
                          controller: registerPasswordShopController,
                          type: TextInputType.visiblePassword,
                          lapel: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          isPassword: SocialRegisterCubit.get(context).isPasswordShown,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Password';
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
                          controller: registerPhoneShopController,
                          type: TextInputType.phone,
                          lapel: 'Phone'.toUpperCase(),
                          prefix: Icons.phone_android_outlined,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadingState,
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        builder: (BuildContext context) {
                          return defaulButton(
                            text: 'Register'.toUpperCase(),
                            isUpperCase: true,
                            pressed: ()
                            {
                              if (formKey.currentState!.validate())
                              {
                                SocialRegisterCubit.get(context).userRegister(
                                  name:registerNameShopController.text,
                                  phone:registerPhoneShopController.text ,
                                  email: registerEmailShopController.text,
                                  password: registerPasswordShopController.text,
                                );
                              }
                            },
                          );
                        },
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
