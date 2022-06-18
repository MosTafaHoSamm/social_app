import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social3/Modules/register_screen/register_cubit/register_cubit.dart';
import 'package:social3/Modules/register_screen/register_cubit/register_state.dart';


import '../../layout/social_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/icon_broken.dart';
import '../login_screen/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if(state is CreateUserSuccessState)
              {
                navigateAndFinish(context: context, widget: SocialLayout());
                CacheHelper.saveData(key: 'uId', value: state.uId);
              }
          },
          builder: (context, state) {
            var cubit = RegisterCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                    'assets/images/register.png',
                                  )),
                            ]),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Register Screen",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 26),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextForm(
                            text: 'name',
                            controller: nameController,
                            iconPrefix: IconBroken.User,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'this field must not be empty ';
                              } else {
                                return null;
                              }
                            },
                            type: TextInputType.name,
                            onChange: (String value) {
                              print(value);
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            text: 'email',
                            controller: emailController,
                            iconPrefix: Icons.email,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'this field must not be empty ';
                              } else {
                                return null;
                              }
                            },
                            onChange: (String value) {
                              print(value);
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            text: 'password',
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            iconPrefix: IconBroken.Lock,
                            obsecure: true,
                            suffixIcon: Icons.visibility,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'this field must not be empty ';
                              } else {
                                return null;
                              }
                            },
                            onChange: (String value) {
                              print(value);
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            text: 'phone',
                            type: TextInputType.phone,
                            controller: phoneController,
                            iconPrefix: IconBroken.Call,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'this field must not be empty ';
                              } else {
                                return null;
                              }
                            },
                            onChange: (String value) {
                              print(value);
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: (state is! RegisterLoadingState),
                          builder: (context) => defaultButton(
                            text: 'Register',
                            onPressed: () {
                              if(formKey.currentState.validate())
                                {
                                  print('Register Pressed');
                                  cubit.userRegister(
                                    name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }

                            },
                          ),
                          fallback: (context) {
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Have an account ?',
                                style: TextStyle(color: Colors.grey),
                              ),
                              defaultTextButton(
                                  text: 'Login',
                                  onPressed: () {
                                    navigateAndFinish(
                                        context: context, widget: LoginScreen());
                                  }),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
