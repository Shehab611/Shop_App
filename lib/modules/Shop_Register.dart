// ignore_for_file: file_names, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Cubit/register_cubit.dart';
import 'package:shop/core/Cachehelper.dart';
import 'package:shop/core/components1.dart';
import 'package:shop/modules/ShopLayout.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController nameControler = TextEditingController();
  TextEditingController phoneControler = TextEditingController();
  var frmkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
         if (state is RegisterSuccess) {
          if (state.loginModel.status) {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data.token)
                .then((value) {
              navigatandfinsh(context: context, screen: const ShopScreen());
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
        RegisterCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Register to our Shop App'),
          ),
          body: Form(
            key: frmkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    defulttextformfieled(
                        label: 'Name',
                        controller: nameControler,
                        type: TextInputType.text,
                        prefix: Icons.verified_user,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name Must be Entered';
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    defulttextformfieled(
                        label: 'Phone',
                        controller: phoneControler,
                        type: TextInputType.number,
                        prefix: Icons.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Phone Must be Entered';
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    defulttextformfieled(
                        label: 'E-mail',
                        controller: emailControler,
                        type: TextInputType.emailAddress,
                        prefix: Icons.email,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email Must be Entered';
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    defulttextformfieled(
                        suffix: cubit.suffix,
                        isPassword: cubit.isPassword,
                        suffixPressed: () {
                          cubit.suffuxpress();
                        },
                        label: 'Password',
                        controller: passwordControler,
                        type: TextInputType.text,
                        prefix: Icons.lock,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Password Must be Entered';
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    ConditionalBuilder(
                      condition: state is! RegisterLoading,
                      builder: (context) => btn(
                          onPress: () {
                            if (frmkey.currentState!.validate()) {
                              cubit.registerUser(
                                email: emailControler.text.toString(),
                                password: passwordControler.text.toString(),
                                phone: phoneControler.text.toString(),
                                name: nameControler.text.toString(),
                              );
                            }
                          },
                          text: 'Sign Up',
                          background: Colors.deepOrange),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
