part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  ShopLoginModel loginModel;
  LoginSuccess(this.loginModel);
}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String error;
  
  LoginError(this.error);
}

class IsPassword extends LoginState {}
