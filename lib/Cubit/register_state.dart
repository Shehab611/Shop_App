

part of 'register_cubit.dart';





abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class IsPassword extends RegisterState {}
class RegisterSuccess extends RegisterState {
    ShopLoginModel loginModel;
  RegisterSuccess(this.loginModel);  
}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {
  final String error;
  
  RegisterError(this.error);
}