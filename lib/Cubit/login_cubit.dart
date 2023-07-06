
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/core/Dio.dart';
import 'package:shop/models/ShopLoginModel.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  ShopLoginModel? userModel;

  IconData suffix = Icons.remove_red_eye_rounded;
  bool isPassword = true;
  void suffuxpress() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.remove_red_eye_rounded
        : Icons.visibility_off_rounded;

    emit(IsPassword());
  }

  void loginUser(
      {required String email, required String password,}) {
    emit(LoginLoading());
    DioHelper.postdata(
        url: 'login',
        data: {'email': email, 'password': password}).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(LoginSuccess(userModel!));
   
    }).catchError((error) {

      emit(LoginError(error.toString()));
    });
  }
}
