

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/core/Dio.dart';


import '../models/ShopLoginModel.dart';

part  'register_state.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  IconData suffix = Icons.remove_red_eye_rounded;
  bool isPassword = true;
  void suffuxpress() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.remove_red_eye_rounded
        : Icons.visibility_off_rounded;

    emit(IsPassword());
  }

  ShopLoginModel? userModel;
  void registerUser(
      {required String email,
      required String password,
      required String phone,
      required String name}) {
    emit(RegisterLoading());
    DioHelper.postdata(url: 'register', data: {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name
    }).then((value) {
     // print('start');
      userModel = ShopLoginModel.fromJson(value.data);
     // print(userModel!.status);
      emit(RegisterSuccess(userModel!));
    }).catchError((error) {
    //  print(error.toString());
      emit(RegisterError(error.toString()));
    });
  }
}
