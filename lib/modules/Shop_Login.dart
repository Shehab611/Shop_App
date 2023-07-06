// ignore_for_file: file_names, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Cubit/login_cubit.dart';
import 'package:shop/core/Cachehelper.dart';
import 'package:shop/core/Dio.dart';
import 'package:shop/core/components1.dart';
import 'package:shop/modules/ShopLayout.dart';
import 'package:shop/modules/Shop_Register.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var frmkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                navigatandfinsh(context: context, screen:const ShopScreen());
              });
              showToast(
                  message: state.loginModel.message, state: ToastState.success);
            } else {
              showToast(
                  message: state.loginModel.message, state: ToastState.error);
            }
          }
        },
        builder: (context, state) {
          LoginCubit cubit = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: frmkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          defulttextformfieled(
                              label: 'Email Address',
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              prefix: Icons.email_outlined,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Email Must be Entered';
                                }
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          defulttextformfieled(
                            label: 'Password',
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            prefix: Icons.lock_outline_rounded,
                            onSubmit: (String? value) {
                              if (frmkey.currentState!.validate()) {
                                cubit.loginUser(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password Must be Entered';
                              }
                            },
                            suffix: cubit.suffix,
                            isPassword: cubit.isPassword,
                            suffixPressed: () {
                              cubit.suffuxpress();
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoading,
                            builder: (context) => btn(
                                text: 'Login',
                                onPress: () {
                                  if (frmkey.currentState!.validate()) {
                                    cubit.loginUser(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                }),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              const Text('Dont have an account'),
                              const Spacer(),
                              TextButton(
                                  onPressed: () {
                                    navigatto(
                                        context: context,
                                        screen: RegisterScreen());
                                  },
                                  child: const Text('Register Now'))
                            ],
                          )
                        ]),
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
